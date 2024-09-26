# Traitement des images .ps générées par Cast3M pour les intégrer dans la documentation

# Au programme :
# - extraction de certaines pages des fichiers .ps
# - convertion des images en .eps (suppression des marges) puis en .png
# - menage des images .ps et .eps

# Dépendances :
# psselect
# cast-post.sh (S. Gounand)
# ps2eps
# convert (imagemagick)


# Création d'un répertoire qui contiendra les images créées
cp ../dgibi/01_traction.ps .
cp ../dgibi/02_compression.ps .
cp ../dgibi/08_biaxial.ps .

# Retrait des titres
echo "  --> Suppression des titres"
cast-post.sh -o -t 01_traction.ps 01_traction.ps
cast-post.sh -o -t 02_compression.ps 02_compression.ps
cast-post.sh -o -t 08_biaxial.ps  08_biaxial.ps

# Extraction des pages utilses
echo "  --> Extraction des pages"
psselect -q -p1    01_traction.ps mazars_trac_mono_char_3d.ps
psselect -q -p2    01_traction.ps mazars_trac_mono_d_3d.ps
psselect -q -p3    01_traction.ps mazars_trac_mono_s_3d.ps
psselect -q -p4    01_traction.ps mazars_trac_mono_f_3d.ps
psselect -q -p9    01_traction.ps mazars_trac_mono_char_3dpaf.ps
psselect -q -p10   01_traction.ps mazars_trac_mono_d_3dpaf.ps
psselect -q -p11   01_traction.ps mazars_trac_mono_s_3dpaf.ps
psselect -q -p12   01_traction.ps mazars_trac_mono_f_3dpaf.ps
psselect -q -p14   01_traction.ps mazars_trac_mono_char_2dplan.ps
psselect -q -p15   01_traction.ps mazars_trac_mono_d_2dplan.ps
psselect -q -p16   01_traction.ps mazars_trac_mono_s_2dplan.ps
psselect -q -p17   01_traction.ps mazars_trac_mono_f_2dplan.ps
psselect -q -p22   01_traction.ps mazars_trac_mono_char_2daxi.ps
psselect -q -p23   01_traction.ps mazars_trac_mono_d_2daxi.ps
psselect -q -p24   01_traction.ps mazars_trac_mono_s_2daxi.ps
psselect -q -p25   01_traction.ps mazars_trac_mono_f_2daxi.ps
psselect -q -p30   01_traction.ps mazars_trac_mono_char_2dpaf.ps
psselect -q -p31   01_traction.ps mazars_trac_mono_d_2dpaf.ps
psselect -q -p32   01_traction.ps mazars_trac_mono_s_2dpaf.ps
psselect -q -p33   01_traction.ps mazars_trac_mono_f_2dpaf.ps
psselect -q -p1    02_compression.ps mazars_comp_mono_char_3d.ps
psselect -q -p2    02_compression.ps mazars_comp_mono_d_3d.ps
psselect -q -p3    02_compression.ps mazars_comp_mono_s_3d.ps
psselect -q -p4    02_compression.ps mazars_comp_mono_f_3d.ps
psselect -q -p9    02_compression.ps mazars_comp_mono_char_3dpaf.ps
psselect -q -p10   02_compression.ps mazars_comp_mono_d_3dpaf.ps
psselect -q -p11   02_compression.ps mazars_comp_mono_s_3dpaf.ps
psselect -q -p12   02_compression.ps mazars_comp_mono_f_3dpaf.ps
psselect -q -p14   02_compression.ps mazars_comp_mono_char_2dplan.ps
psselect -q -p15   02_compression.ps mazars_comp_mono_d_2dplan.ps
psselect -q -p16   02_compression.ps mazars_comp_mono_s_2dplan.ps
psselect -q -p17   02_compression.ps mazars_comp_mono_f_2dplan.ps
psselect -q -p22   02_compression.ps mazars_comp_mono_char_2daxi.ps
psselect -q -p23   02_compression.ps mazars_comp_mono_d_2daxi.ps
psselect -q -p24   02_compression.ps mazars_comp_mono_s_2daxi.ps
psselect -q -p25   02_compression.ps mazars_comp_mono_f_2daxi.ps
psselect -q -p30   02_compression.ps mazars_comp_mono_char_2dpaf.ps
psselect -q -p31   02_compression.ps mazars_comp_mono_d_2dpaf.ps
psselect -q -p32   02_compression.ps mazars_comp_mono_s_2dpaf.ps
psselect -q -p33   02_compression.ps mazars_comp_mono_f_2dpaf.ps
psselect -q -p1    08_biaxial.ps  mazars_biax_char_3d.ps
psselect -q -p2    08_biaxial.ps  mazars_biax_3d.ps
psselect -q -p3    08_biaxial.ps  mazars_biax_char_2d.ps
psselect -q -p4    08_biaxial.ps  mazars_biax_2d.ps

# Traitement des images
rm 01_traction.ps
rm 01_compression.ps
rm 08_biaxial.ps
echo "  --> Augmentation de l'épaisseur des lignes"
cast-post.sh -o -l 5 mazars_trac_mono_char_3d.ps     mazars_trac_mono_char_3d.ps
cast-post.sh -o -l 5 mazars_trac_mono_char_3dpaf.ps  mazars_trac_mono_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_trac_mono_char_2dplan.ps mazars_trac_mono_char_2dplan.ps
cast-post.sh -o -l 5 mazars_trac_mono_char_2daxi.ps  mazars_trac_mono_char_2daxi.ps
cast-post.sh -o -l 5 mazars_trac_mono_char_2dpaf.ps  mazars_trac_mono_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_comp_mono_char_3d.ps     mazars_comp_mono_char_3d.ps
cast-post.sh -o -l 5 mazars_comp_mono_char_3dpaf.ps  mazars_comp_mono_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_comp_mono_char_2dplan.ps mazars_comp_mono_char_2dplan.ps
cast-post.sh -o -l 5 mazars_comp_mono_char_2daxi.ps  mazars_comp_mono_char_2daxi.ps
cast-post.sh -o -l 5 mazars_comp_mono_char_2dpaf.ps  mazars_comp_mono_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_biax_char_3d.ps          mazars_biax_char_3d.ps
cast-post.sh -o -l 5 mazars_biax_char_2d.ps          mazars_biax_char_2d.ps
echo "  --> Convertion en eps (ajout de la bounding box)"
for fic in *.ps
do
  ps2eps -R + $fic >/dev/null 2>&1
done
echo "  --> Convertion en png"
for fic in *.eps
do
  fic2=`basename $fic .eps`.png
  convert $fic $fic2
done
rm *.ps *.eps
