# Traitement des images .ps générées par Cast3M pour les intégrer dans la documentation

# Au programme :
# - extraction de certaines pages des fichiers .ps
# - Conversion des images en .eps (suppression des marges) puis en .png
# - menage des images .ps et .eps

# Dépendances :
# psselect
# cast-post.sh (S. Gounand)
# ps2eps
# convert (imagemagick)


# Création d'un répertoire qui contiendra les images créées
cp ../dgibi/mazars_traction.ps .
cp ../dgibi/mazars_compression.ps .
cp ../dgibi/mazars_traction_cyclique.ps .
cp ../dgibi/mazars_compression_cyclique.ps .
cp ../dgibi/mazars_traction_compression.ps .
cp ../dgibi/mazars_traction_compression_traction.ps .
cp ../dgibi/mazars_cisaillement_Beta_1.06.ps .
cp ../dgibi/mazars_cisaillement_Beta_1.00.ps .
cp ../dgibi/mazars_biaxial.ps .
cp ../dgibi/mazars_triaxial.ps .
cp ../dgibi/mazars_willam.ps .

# Retrait des titres
echo "  --> Suppression des titres"
cast-post.sh -o -t mazars_traction.ps mazars_traction.ps
cast-post.sh -o -t mazars_compression.ps mazars_compression.ps
cast-post.sh -o -t mazars_traction_cyclique.ps mazars_traction_cyclique.ps
cast-post.sh -o -t mazars_compression_cyclique.ps mazars_compression_cyclique.ps
cast-post.sh -o -t mazars_traction_compression.ps mazars_traction_compression.ps
cast-post.sh -o -t mazars_traction_compression_traction.ps mazars_traction_compression_traction.ps
cast-post.sh -o -t mazars_cisaillement_Beta_1.06.ps mazars_cisaillement_Beta_1.06.ps
cast-post.sh -o -t mazars_cisaillement_Beta_1.00.ps mazars_cisaillement_Beta_1.00.ps
cast-post.sh -o -t mazars_biaxial.ps mazars_biaxial.ps
cast-post.sh -o -t mazars_triaxial.ps mazars_triaxial.ps
cast-post.sh -o -t mazars_willam.ps mazars_willam.ps

# Extraction des pages utilisées
echo "  --> Extraction des pages"
psselect -q -p2    mazars_traction.ps mazars_trac_mono_char_3d.ps
psselect -q -p3    mazars_traction.ps mazars_trac_mono_d_3d.ps
psselect -q -p4    mazars_traction.ps mazars_trac_mono_s_3d.ps
psselect -q -p5    mazars_traction.ps mazars_trac_mono_f_3d.ps
psselect -q -p12   mazars_traction.ps mazars_trac_mono_char_3dpaf.ps
psselect -q -p13   mazars_traction.ps mazars_trac_mono_d_3dpaf.ps
psselect -q -p14   mazars_traction.ps mazars_trac_mono_s_3dpaf.ps
psselect -q -p15   mazars_traction.ps mazars_trac_mono_f_3dpaf.ps
psselect -q -p19   mazars_traction.ps mazars_trac_mono_char_2dplan.ps
psselect -q -p20   mazars_traction.ps mazars_trac_mono_d_2dplan.ps
psselect -q -p21   mazars_traction.ps mazars_trac_mono_s_2dplan.ps
psselect -q -p22   mazars_traction.ps mazars_trac_mono_f_2dplan.ps
psselect -q -p29   mazars_traction.ps mazars_trac_mono_char_2daxi.ps
psselect -q -p30   mazars_traction.ps mazars_trac_mono_d_2daxi.ps
psselect -q -p31   mazars_traction.ps mazars_trac_mono_s_2daxi.ps
psselect -q -p32   mazars_traction.ps mazars_trac_mono_f_2daxi.ps
psselect -q -p39   mazars_traction.ps mazars_trac_mono_char_2dpaf.ps
psselect -q -p40   mazars_traction.ps mazars_trac_mono_d_2dpaf.ps
psselect -q -p41   mazars_traction.ps mazars_trac_mono_s_2dpaf.ps
psselect -q -p42   mazars_traction.ps mazars_trac_mono_f_2dpaf.ps
psselect -q -p2    mazars_compression.ps mazars_comp_mono_char_3d.ps
psselect -q -p3    mazars_compression.ps mazars_comp_mono_d_3d.ps
psselect -q -p4    mazars_compression.ps mazars_comp_mono_s_3d.ps
psselect -q -p5    mazars_compression.ps mazars_comp_mono_f_3d.ps
psselect -q -p12   mazars_compression.ps mazars_comp_mono_char_3dpaf.ps
psselect -q -p13   mazars_compression.ps mazars_comp_mono_d_3dpaf.ps
psselect -q -p14   mazars_compression.ps mazars_comp_mono_s_3dpaf.ps
psselect -q -p15   mazars_compression.ps mazars_comp_mono_f_3dpaf.ps
psselect -q -p19   mazars_compression.ps mazars_comp_mono_char_2dplan.ps
psselect -q -p20   mazars_compression.ps mazars_comp_mono_d_2dplan.ps
psselect -q -p21   mazars_compression.ps mazars_comp_mono_s_2dplan.ps
psselect -q -p22   mazars_compression.ps mazars_comp_mono_f_2dplan.ps
psselect -q -p29   mazars_compression.ps mazars_comp_mono_char_2daxi.ps
psselect -q -p30   mazars_compression.ps mazars_comp_mono_d_2daxi.ps
psselect -q -p31   mazars_compression.ps mazars_comp_mono_s_2daxi.ps
psselect -q -p32   mazars_compression.ps mazars_comp_mono_f_2daxi.ps
psselect -q -p39   mazars_compression.ps mazars_comp_mono_char_2dpaf.ps
psselect -q -p40   mazars_compression.ps mazars_comp_mono_d_2dpaf.ps
psselect -q -p41   mazars_compression.ps mazars_comp_mono_s_2dpaf.ps
psselect -q -p42   mazars_compression.ps mazars_comp_mono_f_2dpaf.ps
psselect -q -p2    mazars_traction_cyclique.ps mazars_trac_cycl_char_3d.ps
psselect -q -p3    mazars_traction_cyclique.ps mazars_trac_cycl_d_3d.ps
psselect -q -p4    mazars_traction_cyclique.ps mazars_trac_cycl_s_3d.ps
psselect -q -p5    mazars_traction_cyclique.ps mazars_trac_cycl_f_3d.ps
psselect -q -p12   mazars_traction_cyclique.ps mazars_trac_cycl_char_3dpaf.ps
psselect -q -p13   mazars_traction_cyclique.ps mazars_trac_cycl_d_3dpaf.ps
psselect -q -p14   mazars_traction_cyclique.ps mazars_trac_cycl_s_3dpaf.ps
psselect -q -p15   mazars_traction_cyclique.ps mazars_trac_cycl_f_3dpaf.ps
psselect -q -p19   mazars_traction_cyclique.ps mazars_trac_cycl_char_2dplan.ps
psselect -q -p20   mazars_traction_cyclique.ps mazars_trac_cycl_d_2dplan.ps
psselect -q -p21   mazars_traction_cyclique.ps mazars_trac_cycl_s_2dplan.ps
psselect -q -p22   mazars_traction_cyclique.ps mazars_trac_cycl_f_2dplan.ps
psselect -q -p29   mazars_traction_cyclique.ps mazars_trac_cycl_char_2daxi.ps
psselect -q -p30   mazars_traction_cyclique.ps mazars_trac_cycl_d_2daxi.ps
psselect -q -p31   mazars_traction_cyclique.ps mazars_trac_cycl_s_2daxi.ps
psselect -q -p32   mazars_traction_cyclique.ps mazars_trac_cycl_f_2daxi.ps
psselect -q -p39   mazars_traction_cyclique.ps mazars_trac_cycl_char_2dpaf.ps
psselect -q -p40   mazars_traction_cyclique.ps mazars_trac_cycl_d_2dpaf.ps
psselect -q -p41   mazars_traction_cyclique.ps mazars_trac_cycl_s_2dpaf.ps
psselect -q -p42   mazars_traction_cyclique.ps mazars_trac_cycl_f_2dpaf.ps
psselect -q -p2    mazars_compression_cyclique.ps mazars_comp_cycl_char_3d.ps
psselect -q -p3    mazars_compression_cyclique.ps mazars_comp_cycl_d_3d.ps
psselect -q -p4    mazars_compression_cyclique.ps mazars_comp_cycl_s_3d.ps
psselect -q -p5    mazars_compression_cyclique.ps mazars_comp_cycl_f_3d.ps
psselect -q -p12   mazars_compression_cyclique.ps mazars_comp_cycl_char_3dpaf.ps
psselect -q -p13   mazars_compression_cyclique.ps mazars_comp_cycl_d_3dpaf.ps
psselect -q -p14   mazars_compression_cyclique.ps mazars_comp_cycl_s_3dpaf.ps
psselect -q -p15   mazars_compression_cyclique.ps mazars_comp_cycl_f_3dpaf.ps
psselect -q -p19   mazars_compression_cyclique.ps mazars_comp_cycl_char_2dplan.ps
psselect -q -p20   mazars_compression_cyclique.ps mazars_comp_cycl_d_2dplan.ps
psselect -q -p21   mazars_compression_cyclique.ps mazars_comp_cycl_s_2dplan.ps
psselect -q -p22   mazars_compression_cyclique.ps mazars_comp_cycl_f_2dplan.ps
psselect -q -p29   mazars_compression_cyclique.ps mazars_comp_cycl_char_2daxi.ps
psselect -q -p30   mazars_compression_cyclique.ps mazars_comp_cycl_d_2daxi.ps
psselect -q -p31   mazars_compression_cyclique.ps mazars_comp_cycl_s_2daxi.ps
psselect -q -p32   mazars_compression_cyclique.ps mazars_comp_cycl_f_2daxi.ps
psselect -q -p39   mazars_compression_cyclique.ps mazars_comp_cycl_char_2dpaf.ps
psselect -q -p40   mazars_compression_cyclique.ps mazars_comp_cycl_d_2dpaf.ps
psselect -q -p41   mazars_compression_cyclique.ps mazars_comp_cycl_s_2dpaf.ps
psselect -q -p42   mazars_compression_cyclique.ps mazars_comp_cycl_f_2dpaf.ps
psselect -q -p2    mazars_traction_compression.ps mazars_trac_comp_char_3d.ps
psselect -q -p3    mazars_traction_compression.ps mazars_trac_comp_d_3d.ps
psselect -q -p4    mazars_traction_compression.ps mazars_trac_comp_s_3d.ps
psselect -q -p5    mazars_traction_compression.ps mazars_trac_comp_f_3d.ps
psselect -q -p14   mazars_traction_compression.ps mazars_trac_comp_char_3dpaf.ps
psselect -q -p15   mazars_traction_compression.ps mazars_trac_comp_d_3dpaf.ps
psselect -q -p16   mazars_traction_compression.ps mazars_trac_comp_s_3dpaf.ps
psselect -q -p17   mazars_traction_compression.ps mazars_trac_comp_f_3dpaf.ps
psselect -q -p23   mazars_traction_compression.ps mazars_trac_comp_char_2dplan.ps
psselect -q -p24   mazars_traction_compression.ps mazars_trac_comp_d_2dplan.ps
psselect -q -p25   mazars_traction_compression.ps mazars_trac_comp_s_2dplan.ps
psselect -q -p26   mazars_traction_compression.ps mazars_trac_comp_f_2dplan.ps
psselect -q -p35   mazars_traction_compression.ps mazars_trac_comp_char_2daxi.ps
psselect -q -p36   mazars_traction_compression.ps mazars_trac_comp_d_2daxi.ps
psselect -q -p37   mazars_traction_compression.ps mazars_trac_comp_s_2daxi.ps
psselect -q -p38   mazars_traction_compression.ps mazars_trac_comp_f_2daxi.ps
psselect -q -p47   mazars_traction_compression.ps mazars_trac_comp_char_2dpaf.ps
psselect -q -p48   mazars_traction_compression.ps mazars_trac_comp_d_2dpaf.ps
psselect -q -p49   mazars_traction_compression.ps mazars_trac_comp_s_2dpaf.ps
psselect -q -p50   mazars_traction_compression.ps mazars_trac_comp_f_2dpaf.ps
psselect -q -p2    mazars_traction_compression_traction.ps mazars_trac_comp_trac_char_3d.ps
psselect -q -p3    mazars_traction_compression_traction.ps mazars_trac_comp_trac_d_3d.ps
psselect -q -p4    mazars_traction_compression_traction.ps mazars_trac_comp_trac_s_3d.ps
psselect -q -p5    mazars_traction_compression_traction.ps mazars_trac_comp_trac_f_3d.ps
psselect -q -p15   mazars_traction_compression_traction.ps mazars_trac_comp_trac_char_3dpaf.ps
psselect -q -p16   mazars_traction_compression_traction.ps mazars_trac_comp_trac_d_3dpaf.ps
psselect -q -p17   mazars_traction_compression_traction.ps mazars_trac_comp_trac_s_3dpaf.ps
psselect -q -p18   mazars_traction_compression_traction.ps mazars_trac_comp_trac_f_3dpaf.ps
psselect -q -p25   mazars_traction_compression_traction.ps mazars_trac_comp_trac_char_2dplan.ps
psselect -q -p26   mazars_traction_compression_traction.ps mazars_trac_comp_trac_d_2dplan.ps
psselect -q -p27   mazars_traction_compression_traction.ps mazars_trac_comp_trac_s_2dplan.ps
psselect -q -p28   mazars_traction_compression_traction.ps mazars_trac_comp_trac_f_2dplan.ps
psselect -q -p38   mazars_traction_compression_traction.ps mazars_trac_comp_trac_char_2daxi.ps
psselect -q -p39   mazars_traction_compression_traction.ps mazars_trac_comp_trac_d_2daxi.ps
psselect -q -p40   mazars_traction_compression_traction.ps mazars_trac_comp_trac_s_2daxi.ps
psselect -q -p41   mazars_traction_compression_traction.ps mazars_trac_comp_trac_f_2daxi.ps
psselect -q -p51   mazars_traction_compression_traction.ps mazars_trac_comp_trac_char_2dpaf.ps
psselect -q -p52   mazars_traction_compression_traction.ps mazars_trac_comp_trac_d_2dpaf.ps
psselect -q -p53   mazars_traction_compression_traction.ps mazars_trac_comp_trac_s_2dpaf.ps
psselect -q -p54   mazars_traction_compression_traction.ps mazars_trac_comp_trac_f_2dpaf.ps
psselect -q -p2    mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_char_3d.ps
psselect -q -p3    mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_d_3d.ps
psselect -q -p4    mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_s_3d.ps
psselect -q -p10   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_char_3dpaf.ps
psselect -q -p11   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_d_3dpaf.ps
psselect -q -p12   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_s_3dpaf.ps
psselect -q -p15   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_char_2dplan.ps
psselect -q -p16   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_d_2dplan.ps
psselect -q -p17   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_s_2dplan.ps
psselect -q -p23   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_char_2dpaf.ps
psselect -q -p24   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_d_2dpaf.ps
psselect -q -p25   mazars_cisaillement_Beta_1.06.ps mazars_cisa_mono_beta1.06_s_2dpaf.ps
psselect -q -p2    mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_char_3d.ps
psselect -q -p3    mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_d_3d.ps
psselect -q -p4    mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_s_3d.ps
psselect -q -p10   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_char_3dpaf.ps
psselect -q -p11   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_d_3dpaf.ps
psselect -q -p12   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_s_3dpaf.ps
psselect -q -p15   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_char_2dplan.ps
psselect -q -p16   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_d_2dplan.ps
psselect -q -p17   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_s_2dplan.ps
psselect -q -p23   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_char_2dpaf.ps
psselect -q -p24   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_d_2dpaf.ps
psselect -q -p25   mazars_cisaillement_Beta_1.00.ps mazars_cisa_mono_beta1_s_2dpaf.ps
psselect -q -p2    mazars_biaxial.ps  mazars_biax_char_3d.ps
psselect -q -p6    mazars_biaxial.ps  mazars_biax_SxSy_3d.ps
psselect -q -p7    mazars_biaxial.ps  mazars_biax_SxSysFc_3d.ps
psselect -q -p13   mazars_biaxial.ps  mazars_biax_char_2dplan.ps
psselect -q -p17   mazars_biaxial.ps  mazars_biax_SxSy_2dplan.ps
psselect -q -p18   mazars_biaxial.ps  mazars_biax_SxSysFc_2dplan.ps
psselect -q -p5    mazars_triaxial.ps mazars_triax_0MPa_char_3d.ps
psselect -q -p11   mazars_triaxial.ps mazars_triax_9MPa_char_3d.ps
psselect -q -p13   mazars_triaxial.ps mazars_triax_d_3d.ps
psselect -q -p14   mazars_triaxial.ps mazars_triax_s_3d.ps
psselect -q -p15   mazars_triaxial.ps mazars_triax_f_3d.ps
psselect -q -p25   mazars_triaxial.ps mazars_triax_0MPa_char_2daxi.ps
psselect -q -p31   mazars_triaxial.ps mazars_triax_9MPa_char_2daxi.ps
psselect -q -p33   mazars_triaxial.ps mazars_triax_d_2daxi.ps
psselect -q -p34   mazars_triaxial.ps mazars_triax_s_2daxi.ps
psselect -q -p35   mazars_triaxial.ps mazars_triax_f_2daxi.ps
psselect -q -p2    mazars_willam.ps  mazars_will_d_3d.ps
psselect -q -p10   mazars_willam.ps  mazars_will_s_3d.ps
psselect -q -p17   mazars_willam.ps  mazars_will_char_3d.ps
psselect -q -p18   mazars_willam.ps  mazars_will_prin_3d.ps
psselect -q -p20   mazars_willam.ps  mazars_will_d_2dplan.ps
psselect -q -p28   mazars_willam.ps  mazars_will_s_2dplan.ps
psselect -q -p35   mazars_willam.ps  mazars_will_char_2dplan.ps
psselect -q -p36   mazars_willam.ps  mazars_will_prin_2dplan.ps

# Traitement des images
rm mazars_traction.ps
rm mazars_compression.ps
rm mazars_traction_cyclique.ps
rm mazars_compression_cyclique.ps
rm mazars_traction_compression.ps
rm mazars_traction_compression_traction.ps
rm mazars_cisaillement_Beta_1.06.ps
rm mazars_cisaillement_Beta_1.00.ps
rm mazars_biaxial.ps
rm mazars_triaxial.ps
rm mazars_willam.ps
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
cast-post.sh -o -l 5 mazars_cisa_mono_beta1.06_char_3d.ps     mazars_cisa_mono_beta1.06_char_3d.ps
cast-post.sh -o -l 5 mazars_cisa_mono_beta1.06_char_3dpaf.ps  mazars_cisa_mono_beta1.06_char_3dpaf.ps
cast-post.sh -o -l 5 mazars_cisa_mono_beta1.06_char_2dplan.ps mazars_cisa_mono_beta1.06_char_2dplan.ps
cast-post.sh -o -l 5 mazars_cisa_mono_beta1.06_char_2dpaf.ps  mazars_cisa_mono_beta1.06_char_2dpaf.ps
cast-post.sh -o -l 5 mazars_biax_char_3d.ps          mazars_biax_char_3d.ps
cast-post.sh -o -l 5 mazars_biax_char_2dplan.ps      mazars_biax_char_2dplan.ps
cast-post.sh -o -l 5 mazars_triax_0MPa_char_3d.ps    mazars_triax_0MPa_char_3d.ps
cast-post.sh -o -l 5 mazars_triax_9MPa_char_3d.ps    mazars_triax_9MPa_char_3d.ps
cast-post.sh -o -l 5 mazars_triax_0MPa_char_2daxi.ps mazars_triax_0MPa_char_2daxi.ps
cast-post.sh -o -l 5 mazars_triax_9MPa_char_2daxi.ps mazars_triax_9MPa_char_2daxi.ps
cast-post.sh -o -l 5 mazars_will_char_3d.ps          mazars_will_char_3d.ps
cast-post.sh -o -l 5 mazars_will_prin_3d.ps          mazars_will_prin_3d.ps
cast-post.sh -o -l 5 mazars_will_char_2dplan.ps      mazars_will_char_2dplan.ps
cast-post.sh -o -l 5 mazars_will_prin_2dplan.ps      mazars_will_prin_2dplan.ps
echo "  --> Conversion en eps (ajout de la bounding box)"
for fic in *.ps
do
  ps2eps -R + $fic >/dev/null 2>&1
done
echo "  --> Conversion en png"
for fic in *.eps
do
  fic2=`basename $fic .eps`.png
  convert $fic $fic2
done
rm *.ps *.eps
