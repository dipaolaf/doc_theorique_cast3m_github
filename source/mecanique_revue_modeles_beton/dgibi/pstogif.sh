#!/bin/sh
# shellcheck enable=all
#
# NOM         : pstogif.sh
# DESCRIPTION : .ps castem -> mickey animé (Gif ou mp4)
# LANGAGE     : Shell script
# AUTEUR      : Stéphane GOUNAND (CEA/DEN/DM2S/SFME/LTMF)
#               mél : stephane.gounand@cea.fr
# DEPENDANCES : sed, grep
#               gs (GPL Ghostscript 8.61 (2007-11-21)
#               convert (Version: ImageMagick 5.5.4 02/01/03 Q16
#                        http://www.imagemagick.org),
#               csplit
#               parallel (GNU)
#               gifsicle (.gif) ou ffmpeg (.mp4)
# VERSION    : v1, 19/03/2007, version initiale
#              2017/02/23 : suite a evolution Prabel fiches 9177, 9197
#                           (nombre de couleurs nommees passe à 32)
#                           l'operateur CM est remplace par CM4 dans le
#                           Postscript Castem
#                           On integre ce changement
#              2023/09/07 : augmenter la résolution !
#              2023/09/14 : version fast avec GNU Parallel et psplit
#                           Option pour faire du .mp4
#              2023/09/20 : nettoyage et simplification des options
#                           Les post-traitements des fichiers PostScript sont délégués à cast_post
#                           Tests sur des PostScripts générés par Castem19->Castem23
#              v1.1, 10/11/2023, utilisation de shellcheck pour améliorer la robustesse du script
#                                codage UTF-8
#
# Debugging
#set -x
usage () {
echo "${SCRIPT} [-y i] [-f j] [-a] [-m] [-o] [-d] file1.ps ... filen.ps

This script maps .ps files produced by Castem 2000/Cast3M into an
animated .gif or .mp4 file
        Arguments:
                -y : vertical resolution (in pixels) (default i=1080)
                -f : framerate (in frame/s) (default j=30)
                -a : append y f parameters to output filename
                -m : output to mp4 instead of gif
                -o : allows overwriting output?.gif or output?.mp4
                -d : debug (do not delete temporary directory)"
exit 0
}
#
error () {
rm -fr "${mytmpdir}"
echo "Error or interruption in ${SCRIPT}"
exit 1
}
#
exists() {
  command -v "$1" >/dev/null 2>&1
}

SCRIPT=${0##*/}
currdir=$(pwd)
#
if [ $# = 0 ] ;  then
    usage
fi
#
# Y a-t-il les programmes externes qui peuvent être utilisés ?
#
csplit_exists=0 ; ! exists csplit || csplit_exists=$?
parallel_exists=0 ; ! exists parallel || parallel_exists=$?
gs_exists=0 ; ! exists gs || gs_exists=$?
convert_exists=0 ; ! exists convert || convert_exists=$?
gifsicle_exists=0 ; ! exists gifsicle || gifsicle_exists=$?
ffmpeg_exists=0 ; ! exists ffmpeg || ffmpeg_exists=$?
ffprobe_exists=0 ; ! exists ffprobe || ffprobe_exists=$?
# Debug script
# csplit_exists=1
# parallel_exists=0
# gs_exists=1
# convert_exists=1
# gifsicle_exists=1
# ffmpeg_exists=1
# ffprobe_exists=0
#
if [ "${parallel_exists}" -eq 0 ] ; then
    echo "! GNU Parallel (Parallelism in shell scripts) is missing, please consider installing for performance"
fi
if [ "${gs_exists}" -eq 0 ] ; then
    echo "!!! gs utility (GhostScript, PostScript Interpreter) is missing, please install"
    exit 1
fi
#
Yval=1080
Fval=30
Aflag=0
Mflag=0
DELDEST=0
Dflag=0
while getopts "hy:f:amod" Arg ; do
  case ${Arg} in
    h) usage ;;
    y) Yval="${OPTARG}" ;;
    f) Fval="${OPTARG}" ;;
    a) Aflag=1 ;;
    m) Mflag=1 ;;
    o) DELDEST=1 ;;
    d) Dflag=1 ;;
    *) usage ;;
  esac
done
shift $(( OPTIND - 1 ))
# Traitement des options
if [ "${Dflag}" -eq 1 ] ; then
    set -x
fi
if [ ! "${Yval}" -ge 1 ] ; then
     echo "Yval=${Yval} should be greater or equal to 1" ; error
fi
if [ ! "${Fval}" -ge 1 ] ; then
     echo "Fval=${Fval} should be greater or equal to 1" ; error
else
    if [ "${Mflag}" -eq 0 ] ; then
        Dval=$(echo "100/${Fval}" |bc)
        if [ "${Dval}" -lt 1 ] ; then
            Dval=1
        fi
        echo "A frame rate of ${Fval} was asked for so a Delay of ${Dval} (1/100s) was computed"
    fi
fi
if [ "${Mflag}" -eq 0 ] ; then
    if [ "${gifsicle_exists}" -eq 0 ] ; then
        echo "! gifsicle utility (Generate animated gif) is missing, please consider installing"
    fi
else
    if [ "${ffmpeg_exists}" -eq 0 ] ; then
        echo "!!! ffmpeg utility (Generate mp4 movie) is missing, please install"
        exit 1
    fi
fi
# Traitement des exceptions
trap 'error' 2 3
#
#
#
for filename
do
  bfn=$(basename "${filename}" .ps)
  if [ ! -f "${bfn}.ps" ] ;  then
      echo "${bfn}.ps is not a valid file"
      error
  fi
  case "${Aflag}" in
      0) ofn="${bfn}" ;;
      1) ofn="${bfn}-y${Yval}f${Fval}" ;;
      *) echo "Aflag=${Aflag}" not allowed ; error ;;
  esac
  mytmpdir=$(mktemp -d -t "${SCRIPT}.XXXXXXXXXX")
  if [ ! -d "${mytmpdir}" ]; then
      >&2 echo "Failed to create temp directory"
      exit 1
  fi
  if [ "${Mflag}" -eq 0 ] ; then
      outfile="${ofn}.gif"
  else
      outfile="${ofn}.mp4"
  fi
  if [ -f "${outfile}" ] && [ "${DELDEST}" -eq 0 ]; then
    echo "${outfile} already exists" ; error
  fi
  cd "${mytmpdir}" || error
  cp "${currdir}/${bfn}.ps" "./${bfn}.ps"
  #
  #  Découpage du .ps
  #
  motif='%%Page:'
  motifend='%%Trailer'
  npage=$(grep -c "${motif}" "${bfn}.ps")
  npagem="$((npage-1))" ; npagep="$((npage+1))"
  ntrail=$(grep -c "${motifend}" "${bfn}.ps")
  echo "${npage} pages found in ${bfn}.ps"
  if [ "${npage}" -eq 0 ] ; then
      echo "Couldn't find any page. Does your PostScript file follow the DSC (Document Structuring Conventions) ?"
      error
  fi
  ndigitp=$(echo "${npage}" | awk -F '[0-9]' '{print NF-1}')
  sf="%0${ndigitp}d"
  if [ "${csplit_exists}" -eq 0 ] ; then
      echo "!!! csplit utility is missing, please install"
      error
  else
      if [ "${ntrail}" -eq 0 ] ; then
          echo "${motifend}" >> "${bfn}.ps"
      fi
      csplit --quiet --prefix="${bfn}" --suffix-format="${sf}" "${bfn}.ps" "/${motif}/" "{${npagem}}" "/${motifend}/"
  fi
  #
  fm0=$(printf "${sf}" 0)
  prolog="${bfn}${fm0}"
  fmpp=$(printf "${sf}" "${npagep}")
  trailer="${bfn}${fmpp}"
  for i in $(seq 1 "${npage}"); do
      fmi=$(printf "${sf}" "${i}")
      outfile="${bfn}.${fmi}.ps"
      cat "${prolog}" "${bfn}${fmi}" "${trailer}" > "${outfile}"
  done
  #
  # Rasterization (conversion vectoriel->pixel) par GhostScript
  #
  ## Calcul du zoom
  Res=$(echo "${Yval}*100./826.4" |bc -l)
  printf "A vertical resolution of %d was asked for so a zoom factor=%0.2f per cent was computed\n"  "${Yval}" "${Res}"
#  echo "A vertical resolution of $Yval was asked for so a zoom factor=$Res per cent was computed"
  if [ "${parallel_exists}" -eq 0 ] ; then
      for subfile in "${bfn}".*.ps; do
          outfile=$(basename "${subfile}" .ps).png
          gs -dQUIET -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m "-r${Res}" -dTextAlphaBits=4 -dGraphicsAlphaBits=1 -dDOINTERPOLATE -sOutputFile="${outfile}" -c '"<</Orientation 3>> setpagedevice"' -f "${subfile}"
      done
  else
      time parallel gs -dQUIET -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m "-r${Res}" -dTextAlphaBits=4 -dGraphicsAlphaBits=1 -dDOINTERPOLATE -sOutputFile={.}.png -c '"<</Orientation 3>> setpagedevice"' -f {.}.ps ::: "${bfn}".*.ps
  fi
  #
  # Conversion des images en animation
  #
  if [ "${Mflag}" -eq 0 ] ; then
      #
      # Conversion en gif animé
      #
      if [ "${convert_exists}" -eq 0 ] ; then
          echo "!!! convert utility (ImageMagick) is missing, please install"
          exit 1
      fi
      if [ "${gifsicle_exists}" -eq 0 ] ; then
          convert -delay "${Dval}" -coalesce -layers optimize -loop 0 "${bfn}".*.png "${ofn}.gif"
      else
          if [ "${parallel_exists}" -eq 0 ] ; then
              for subfile in "${bfn}".*.png ; do
                  outfile=$(basename "${subfile}" .png).gif
                  convert "${subfile}" "${outfile}"
              done
          else
              time parallel convert {.}.png {.}.gif ::: "${bfn}".*.png
          fi
          Opt=2
          time /usr/bin/gifsicle --loopcount --delay "${Dval}" --careful "-O${Opt}" "${bfn}".*.gif -o "${ofn}.gif"
      fi
      mv "${ofn}.gif" "${currdir}"
  else
      #
      # Conversion en MPEG4
      #
      fm1=$(printf "${sf}" 1)
      firstfile="${bfn}.${fm1}.png"
      if [ ! -f "${firstfile}" ] ;  then
          echo "${firstfile} is not a valid file"
          error
      fi
      ffxres=$(identify -format '%w' "${firstfile}")
      ffyres=$(identify -format '%h' "${firstfile}")
      echo "Horizontal resolution of ${firstfile} = ${ffxres}"
      ffxres2=$(echo "((${ffxres}+1)/2)*2" |bc)
      echo "Rounded horiz resolution of ${firstfile} = ${ffxres2}"
      echo "Vertical resolution of ${firstfile} = ${ffyres}"
      prog="ffmpeg"
      inp="-r ${Fval} -i '${bfn}.${sf}.png' -r ${Fval}"
      cod0="-codec:v libx264 -pix_fmt:v yuv420p -movflags faststart -preset slow -crf 22"
      out0="'${ofn}.mp4'"
      scale=""
      if [ "${ffxres2}" -ne "${ffxres}" ]
      then
          scale="${scale} -filter:v pad=${ffxres2}:${ffyres}"
      fi
      cmd="${prog} ${inp} ${cod0} ${scale} ${out0}"
      echo "Executing ${cmd}"
      eval "${cmd}"
      if [ "${ffprobe_exists}" -eq 0 ] ; then
          ffprobe "${out0}"
      fi
      mv "${ofn}.mp4" "${currdir}"
  fi
  cd "${currdir}" || error
  if [ "${Dflag}" -eq 0 ] ; then
      rm -fr "${mytmpdir}"
  fi
done
exit 0
