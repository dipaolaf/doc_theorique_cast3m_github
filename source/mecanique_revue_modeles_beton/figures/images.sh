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
cp ../dgibi/03_traction_cyclique.ps .
cp ../dgibi/04_compression_cyclique.ps .
cp ../dgibi/05_traction_compression.ps .
cp ../dgibi/06_traction_compression_traction.ps .
cp ../dgibi/08_biaxial.ps .
cp ../dgibi/09_triaxial.ps .
cp ../dgibi/10_willam.ps .

# Retrait des titres
echo "  --> Suppression des titres"
cast-post.sh -o -t 01_traction.ps 01_traction.ps
cast-post.sh -o -t 02_compression.ps 02_compression.ps
cast-post.sh -o -t 03_traction_cyclique.ps 03_traction_cyclique.ps
cast-post.sh -o -t 04_compression_cyclique.ps 04_compression_cyclique.ps
cast-post.sh -o -t 05_traction_compression.ps 05_traction_compression.ps
cast-post.sh -o -t 06_traction_compression_traction.ps 06_traction_compression_traction.ps
cast-post.sh -o -t 08_biaxial.ps 08_biaxial.ps
cast-post.sh -o -t 09_triaxial.ps 09_triaxial.ps
cast-post.sh -o -t 10_willam.ps 10_willam.ps

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
psselect -q -p1    03_traction_cyclique.ps mazars_trac_cycl_char_3d.ps
psselect -q -p2    03_traction_cyclique.ps mazars_trac_cycl_d_3d.ps
psselect -q -p3    03_traction_cyclique.ps mazars_trac_cycl_s_3d.ps
psselect -q -p4    03_traction_cyclique.ps mazars_trac_cycl_f_3d.ps
psselect -q -p9    03_traction_cyclique.ps mazars_trac_cycl_char_3dpaf.ps
psselect -q -p10   03_traction_cyclique.ps mazars_trac_cycl_d_3dpaf.ps
psselect -q -p11   03_traction_cyclique.ps mazars_trac_cycl_s_3dpaf.ps
psselect -q -p12   03_traction_cyclique.ps mazars_trac_cycl_f_3dpaf.ps
psselect -q -p14   03_traction_cyclique.ps mazars_trac_cycl_char_2dplan.ps
psselect -q -p15   03_traction_cyclique.ps mazars_trac_cycl_d_2dplan.ps
psselect -q -p16   03_traction_cyclique.ps mazars_trac_cycl_s_2dplan.ps
psselect -q -p17   03_traction_cyclique.ps mazars_trac_cycl_f_2dplan.ps
psselect -q -p22   03_traction_cyclique.ps mazars_trac_cycl_char_2daxi.ps
psselect -q -p23   03_traction_cyclique.ps mazars_trac_cycl_d_2daxi.ps
psselect -q -p24   03_traction_cyclique.ps mazars_trac_cycl_s_2daxi.ps
psselect -q -p25   03_traction_cyclique.ps mazars_trac_cycl_f_2daxi.ps
psselect -q -p30   03_traction_cyclique.ps mazars_trac_cycl_char_2dpaf.ps
psselect -q -p31   03_traction_cyclique.ps mazars_trac_cycl_d_2dpaf.ps
psselect -q -p32   03_traction_cyclique.ps mazars_trac_cycl_s_2dpaf.ps
psselect -q -p33   03_traction_cyclique.ps mazars_trac_cycl_f_2dpaf.ps
psselect -q -p1    04_compression_cyclique.ps mazars_comp_cycl_char_3d.ps
psselect -q -p2    04_compression_cyclique.ps mazars_comp_cycl_d_3d.ps
psselect -q -p3    04_compression_cyclique.ps mazars_comp_cycl_s_3d.ps
psselect -q -p4    04_compression_cyclique.ps mazars_comp_cycl_f_3d.ps
psselect -q -p9    04_compression_cyclique.ps mazars_comp_cycl_char_3dpaf.ps
psselect -q -p10   04_compression_cyclique.ps mazars_comp_cycl_d_3dpaf.ps
psselect -q -p11   04_compression_cyclique.ps mazars_comp_cycl_s_3dpaf.ps
psselect -q -p12   04_compression_cyclique.ps mazars_comp_cycl_f_3dpaf.ps
psselect -q -p14   04_compression_cyclique.ps mazars_comp_cycl_char_2dplan.ps
psselect -q -p15   04_compression_cyclique.ps mazars_comp_cycl_d_2dplan.ps
psselect -q -p16   04_compression_cyclique.ps mazars_comp_cycl_s_2dplan.ps
psselect -q -p17   04_compression_cyclique.ps mazars_comp_cycl_f_2dplan.ps
psselect -q -p22   04_compression_cyclique.ps mazars_comp_cycl_char_2daxi.ps
psselect -q -p23   04_compression_cyclique.ps mazars_comp_cycl_d_2daxi.ps
psselect -q -p24   04_compression_cyclique.ps mazars_comp_cycl_s_2daxi.ps
psselect -q -p25   04_compression_cyclique.ps mazars_comp_cycl_f_2daxi.ps
psselect -q -p30   04_compression_cyclique.ps mazars_comp_cycl_char_2dpaf.ps
psselect -q -p31   04_compression_cyclique.ps mazars_comp_cycl_d_2dpaf.ps
psselect -q -p32   04_compression_cyclique.ps mazars_comp_cycl_s_2dpaf.ps
psselect -q -p33   04_compression_cyclique.ps mazars_comp_cycl_f_2dpaf.ps
psselect -q -p1    05_traction_compression.ps mazars_trac_comp_char_3d.ps
psselect -q -p2    05_traction_compression.ps mazars_trac_comp_d_3d.ps
psselect -q -p3    05_traction_compression.ps mazars_trac_comp_s_3d.ps
psselect -q -p4    05_traction_compression.ps mazars_trac_comp_f_3d.ps
psselect -q -p11   05_traction_compression.ps mazars_trac_comp_char_3dpaf.ps
psselect -q -p12   05_traction_compression.ps mazars_trac_comp_d_3dpaf.ps
psselect -q -p13   05_traction_compression.ps mazars_trac_comp_s_3dpaf.ps
psselect -q -p14   05_traction_compression.ps mazars_trac_comp_f_3dpaf.ps
psselect -q -p18   05_traction_compression.ps mazars_trac_comp_char_2dplan.ps
psselect -q -p19   05_traction_compression.ps mazars_trac_comp_d_2dplan.ps
psselect -q -p20   05_traction_compression.ps mazars_trac_comp_s_2dplan.ps
psselect -q -p21   05_traction_compression.ps mazars_trac_comp_f_2dplan.ps
psselect -q -p28   05_traction_compression.ps mazars_trac_comp_char_2daxi.ps
psselect -q -p29   05_traction_compression.ps mazars_trac_comp_d_2daxi.ps
psselect -q -p30   05_traction_compression.ps mazars_trac_comp_s_2daxi.ps
psselect -q -p31   05_traction_compression.ps mazars_trac_comp_f_2daxi.ps
psselect -q -p38   05_traction_compression.ps mazars_trac_comp_char_2dpaf.ps
psselect -q -p39   05_traction_compression.ps mazars_trac_comp_d_2dpaf.ps
psselect -q -p40   05_traction_compression.ps mazars_trac_comp_s_2dpaf.ps
psselect -q -p41   05_traction_compression.ps mazars_trac_comp_f_2dpaf.ps
psselect -q -p1    06_traction_compression_traction.ps mazars_trac_comp_trac_char_3d.ps
psselect -q -p2    06_traction_compression_traction.ps mazars_trac_comp_trac_d_3d.ps
psselect -q -p3    06_traction_compression_traction.ps mazars_trac_comp_trac_s_3d.ps
psselect -q -p4    06_traction_compression_traction.ps mazars_trac_comp_trac_f_3d.ps
psselect -q -p12   06_traction_compression_traction.ps mazars_trac_comp_trac_char_3dpaf.ps
psselect -q -p13   06_traction_compression_traction.ps mazars_trac_comp_trac_d_3dpaf.ps
psselect -q -p14   06_traction_compression_traction.ps mazars_trac_comp_trac_s_3dpaf.ps
psselect -q -p15   06_traction_compression_traction.ps mazars_trac_comp_trac_f_3dpaf.ps
psselect -q -p20   06_traction_compression_traction.ps mazars_trac_comp_trac_char_2dplan.ps
psselect -q -p21   06_traction_compression_traction.ps mazars_trac_comp_trac_d_2dplan.ps
psselect -q -p22   06_traction_compression_traction.ps mazars_trac_comp_trac_s_2dplan.ps
psselect -q -p23   06_traction_compression_traction.ps mazars_trac_comp_trac_f_2dplan.ps
psselect -q -p31   06_traction_compression_traction.ps mazars_trac_comp_trac_char_2daxi.ps
psselect -q -p32   06_traction_compression_traction.ps mazars_trac_comp_trac_d_2daxi.ps
psselect -q -p33   06_traction_compression_traction.ps mazars_trac_comp_trac_s_2daxi.ps
psselect -q -p34   06_traction_compression_traction.ps mazars_trac_comp_trac_f_2daxi.ps
psselect -q -p42   06_traction_compression_traction.ps mazars_trac_comp_trac_char_2dpaf.ps
psselect -q -p43   06_traction_compression_traction.ps mazars_trac_comp_trac_d_2dpaf.ps
psselect -q -p44   06_traction_compression_traction.ps mazars_trac_comp_trac_s_2dpaf.ps
psselect -q -p45   06_traction_compression_traction.ps mazars_trac_comp_trac_f_2dpaf.ps
psselect -q -p1    08_biaxial.ps  mazars_biax_char_3d.ps
psselect -q -p4    08_biaxial.ps  mazars_biax_SxSy_3d.ps
psselect -q -p5    08_biaxial.ps  mazars_biax_SxSysFc_3d.ps
psselect -q -p6    08_biaxial.ps  mazars_biax_char_2dplan.ps
psselect -q -p9    08_biaxial.ps  mazars_biax_SxSy_2dplan.ps
psselect -q -p10   08_biaxial.ps  mazars_biax_SxSysFc_2dplan.ps
psselect -q -p4    09_triaxial.ps mazars_triax_char_3d.ps
psselect -q -p5    09_triaxial.ps mazars_triax_d_3d.ps
psselect -q -p6    09_triaxial.ps mazars_triax_s_3d.ps
psselect -q -p7    09_triaxial.ps mazars_triax_f_3d.ps
psselect -q -p15   09_triaxial.ps mazars_triax_char_2daxi.ps
psselect -q -p16   09_triaxial.ps mazars_triax_d_2daxi.ps
psselect -q -p17   09_triaxial.ps mazars_triax_s_2daxi.ps
psselect -q -p18   09_triaxial.ps mazars_triax_f_2daxi.ps
psselect -q -p2    10_willam.ps  mazars_will_d_3d.ps
psselect -q -p10   10_willam.ps  mazars_will_s_3d.ps
psselect -q -p14   10_willam.ps  mazars_will_char_3d.ps
psselect -q -p15   10_willam.ps  mazars_will_prin_3d.ps
psselect -q -p17   10_willam.ps  mazars_will_d_2dplan.ps
psselect -q -p25   10_willam.ps  mazars_will_s_2dplan.ps
psselect -q -p29   10_willam.ps  mazars_will_char_2dplan.ps
psselect -q -p30   10_willam.ps  mazars_will_prin_2dplan.ps

# Traitement des images
rm 01_traction.ps
rm 02_compression.ps
rm 03_traction_cyclique.ps
rm 04_compression_cyclique.ps
rm 05_traction_compression.ps
rm 06_traction_compression_traction.ps
rm 08_biaxial.ps
rm 09_triaxial.ps
rm 10_willam.ps
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
cast-post.sh -o -l 5 mazars_trac_cycl_char_3d.ps     mazars_trac_cycl_char_3d.ps
cast-post.sh -o -l 5 mazars_trac_cycl_char_3dpaf.ps  mazars_trac_cycl_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_trac_cycl_char_2dplan.ps mazars_trac_cycl_char_2dplan.ps
cast-post.sh -o -l 5 mazars_trac_cycl_char_2daxi.ps  mazars_trac_cycl_char_2daxi.ps
cast-post.sh -o -l 5 mazars_trac_cycl_char_2dpaf.ps  mazars_trac_cycl_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_comp_cycl_char_3d.ps     mazars_comp_cycl_char_3d.ps
cast-post.sh -o -l 5 mazars_comp_cycl_char_3dpaf.ps  mazars_comp_cycl_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_comp_cycl_char_2dplan.ps mazars_comp_cycl_char_2dplan.ps
cast-post.sh -o -l 5 mazars_comp_cycl_char_2daxi.ps  mazars_comp_cycl_char_2daxi.ps
cast-post.sh -o -l 5 mazars_comp_cycl_char_2dpaf.ps  mazars_comp_cycl_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_trac_comp_char_3d.ps     mazars_trac_comp_char_3d.ps
cast-post.sh -o -l 5 mazars_trac_comp_char_3dpaf.ps  mazars_trac_comp_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_trac_comp_char_2dplan.ps mazars_trac_comp_char_2dplan.ps
cast-post.sh -o -l 5 mazars_trac_comp_char_2daxi.ps  mazars_trac_comp_char_2daxi.ps
cast-post.sh -o -l 5 mazars_trac_comp_char_2dpaf.ps  mazars_trac_comp_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_trac_comp_trac_char_3d.ps     mazars_trac_comp_trac_char_3d.ps
cast-post.sh -o -l 5 mazars_trac_comp_trac_char_3dpaf.ps  mazars_trac_comp_trac_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_trac_comp_trac_char_2dplan.ps mazars_trac_comp_trac_char_2dplan.ps
cast-post.sh -o -l 5 mazars_trac_comp_trac_char_2daxi.ps  mazars_trac_comp_trac_char_2daxi.ps
cast-post.sh -o -l 5 mazars_trac_comp_trac_char_2dpaf.ps  mazars_trac_comp_trac_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_biax_char_3d.ps          mazars_biax_char_3d.ps
cast-post.sh -o -l 5 mazars_biax_char_2dplan.ps      mazars_biax_char_2dplan.ps
cast-post.sh -o -l 5 mazars_triax_char_3d.ps         mazars_triax_char_3d.ps
cast-post.sh -o -l 5 mazars_triax_char_2daxi.ps      mazars_triax_char_2daxi.ps
cast-post.sh -o -l 5 mazars_will_char_3d.ps          mazars_will_char_3d.ps
cast-post.sh -o -l 5 mazars_will_prin_3d.ps          mazars_will_prin_3d.ps
cast-post.sh -o -l 5 mazars_will_char_2dplan.ps      mazars_will_char_2dplan.ps
cast-post.sh -o -l 5 mazars_will_prin_2dplan.ps      mazars_will_prin_2dplan.ps
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
