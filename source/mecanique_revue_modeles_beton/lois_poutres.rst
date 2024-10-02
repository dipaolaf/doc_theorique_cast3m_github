.. _sec:modeles_beton_lois_poutres:

Lois béton pour les modélisations poutres
=========================================

La liste suivante concerne les lois de comportement pour le béton et applicables
aux éléments finis de poutre. On y distingue :

- Les lois **globales**, pour les barres et poutres usuelles **BARR**, **POUT**, **TIMO**,
  qui sont des relations entre les déformations généralisées
  :math:`(E_x, \Gamma_y, \Gamma_z, \Phi_x, \Phi_y, \Phi_z)` et les contraintes
  généralisées :math:`(F_x, F_y, F_z, M_x, M_y, M_z)`, sans passage par des
  lois matériaux locales. Ces lois ne comportent aucun couplage entre les différents
  modes de fonctionnement (par exemple, entre les moments de flexion, le
  cisaillement ou bien l'effort normal).
- Les lois *semi-globales*, pour les modèles de poutres à fibres et leurs éléments finis de
  section **QUAS**, **TRIS**, **SEGS**, **POJS**, qui sont des relations entre les
  déformations locales (:math:`\varepsilon_{xx}, \gamma_{xy},\gamma_{xz}`)
  et les contraintes locales (:math:`\sigma_{xx}, \sigma_{xy}, \sigma_{xz}`) au niveau de la fibre.

Certaines lois sont disponibles à la fois en globale et en semi-globale.


Loi bi-linéaire BILIN_MOMY
--------------------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **POUT** ou **TIMO**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'BILIN_MOMY' 'POUT'/'TIMO' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique pour la flexion avec écrouissage cinématique (fonction bi-linéaire)
reliant le moment de flexion :math:`M_y` à la courbure :math:`\Phi_y`.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **YMOM** : moment fléchissant de plastification
- **EAYI** : module post-plastification, il s'agit de la pente post-plastification
  de la relation moment-courbure (:math:`M_y / \Phi_y =` **INRY** x **EAYI**)




Loi bi-linéaire BILIN_EFFZ
--------------------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **TIMO**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'BILIN_EFFZ' 'TIMO' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique pour l'effort tranchant avec écrouissage cinématique
(fonction bi-linéaire) reliant l'effort tranchant :math:`F_z` au cisaillement :math:`\Gamma_z`.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **YEFF** : effort tranchant de plastification
- **EAYI** : module post-plastification, il s'agit de la pente post-plastification
  de la relation effort-cisaillement (:math:`F_z / \Gamma_z =` **SECZ** x **EAYI**)






Loi tri-linéaire TAKEMO_MOMY
----------------------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **POUT** ou **TIMO**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'TAKEMO_MOMY' 'POUT'/'TIMO' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable pour la flexion (fonction tri-linéaire)
de Takeda modifiée reliant le moment de flexion :math:`M_y` à la courbure :math:`\Phi_y`.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
La version originale de la loi est publiée dans :

**T. Takeda, M.A. Sozen, N.N. Nielsen,** *Reinforced concrete response to simulated
earthquakes*, Journal of Structural Division, ASCE, Vol. 96, n°ST12, **1970**.

La version modifiée de la loi et utilisée dans Cast3M est publiée dans :

**A. Arede,** *Seismic assessment of reinforced concrete frame structures with a new flexibility
based element*, PhD Thesi, Universidade do Porto préparée au JRC Ispra, **1997**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **TRAC** : courbe décrivant la loi moment-courbure :math:`M_y(\Phi_y)`.
  Si le comportement est symétrique, cette courbe trilinéaire comprend 4 points délimitant :

    - l'origine,
    - la fissuration/endommagement,
    - la plastification,
    - un point définissant le comportement après plastification.

  Si le comportement est non symétrique la courbe comprend 7 points, depuis les
  valeurs négatives (3 points) jusqu'aux valeurs positives (3 points), en passant
  par l'origine.
  
- **SFDP** : dégradation de raideur pour des courbures positives.
- **SFDN** : dégradation de raideur pour des courbures négatives (égale à **SFDP** dans le cas symétrique).
- **PINP** : pincement pour des courbures positives.
- **PINN** : pincement pour des courbures négatives (égale à **PINP** dans le cas symétrique).
- **SRDP** : dégradation de résistance sous chargement cycliques pour des courbures positives.
- **SRDN** : dégradation de résistance sous chargement cycliques pour des courbures négatives (égale à **SRDN** dans le cas symétrique).




Loi tri-linéaire TAKEMO_EFFZ
----------------------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **TIMO**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'TAKEMO_EFFZ' 'TIMO' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable pour l'effort tranchant (fonction tri-linéaire)
de Takeda modifiée reliant l'effort tranchant :math:`F_z` au cisaillement :math:`\Gamma_z`.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
La version originale de la loi est publiée dans :

**T. Takeda, M.A. Sozen, N.N. Nielsen,** *Reinforced concrete response to simulated
earthquakes*, Journal of Structural Division, ASCE, Vol. 96, n°ST12, **1970**.

La version modifiée de la loi et utilisée dans Cast3M est publiée dans :

**A. Arede,** *Seismic assessment of reinforced concrete frame structures with a new flexibility
based element*, PhD Thesi, Universidade do Porto préparée au JRC Ispra, **1997**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **TRAC** : courbe décrivant la loi effort-cisaillement :math:`F_z(\Gamma_z)`.
  Si le comportement est symétrique, cette courbe trilinéaire comprend 4 points délimitant :

    - l'origine,
    - la fissuration/endommagement,
    - la plastification,
    - un point définissant le comportement après plastification.

  Si le comportement est non symétrique la courbe comprend 7 points, depuis les
  valeurs négatives (3 points) jusqu'aux valeurs positives (3 points), en passant
  par l'origine.

- **SFDP** : dégradation de raideur pour des cisaillements positifs.
- **SFDN** : dégradation de raideur pour des cisaillements négatifs (égale à **SFDP** dans le cas symétrique).
- **PINP** : pincement pour des cisaillements positifs.
- **PINN** : pincement pour des cisaillements négatifs (égale à **PINP** dans le cas symétrique).
- **SRDP** : dégradation de résistance sous chargement cycliques pour des cisaillements positifs.
- **SRDN** : dégradation de résistance sous chargement cycliques pour des cisaillements négatifs (égale à **SRDN** dans le cas symétrique).




Loi tri-linéaire GLOBAL
-----------------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **POUT** ou **TIMO**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'GLOBAL' 'POUT'/'TIMO' ;

Description
~~~~~~~~~~~
Ensemble de trois lois de comportement élasto-plastiques découplées pour les
différents types de sollicitation : axiales, flexion et cisaillement (pour les éléments **TIMO** seulement).

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
La loi et son implémentation est documentée dans les notes CEA :

**S.Lavarenne,** *Développement d'éléments globaux pour l'étude du comportement
sismique des structures en béton armé.* Rapport DMT/94-110, **1994**.

**S.Lavarenne,** *Exemple d'application des éléments globaux de Castem 2000 sur une
structure de génie civil irrégulière*. Rapport DMT/95-343, **1995**.

**S.Lavarenne,** *Utilisation de l'élément global de Castem 2000 dans le cas d'un voile en
béton armé*. Rapport DMT/96-371, **1996**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **COMP** : courbe de comportement pour des sollicitations axiales,
  donnant la force axiale :math:`F_x` en fonction du deplacement axial :math:`U_x`.
- **FLXY** : courbe de comportement pour des sollicitations en flexion
  autour de l'axe :math:`y`, donnant le moment de flexion :math:`M_y`
  en fonction du produit rotation :math:`R_y` x longueur de l'element.
- **FLXZ** : courbe de comportement pour des sollicitations en flexion
  autour de l'axe :math:`z`, donnant le moment de flexion :math:`M_z`
  en fonction du produit rotation :math:`R_z` x longueur de l'element.
- **CISY** : courbe de comportement pour des sollicitations en cisaillement
  selon l'axe :math:`y`, donnant l'effort tranchant :math:`F_y`
  en fonction du déplacement :math:`U_y` (pour les éléments **TIMO** seulement).
- **CISZ** : courbe de comportement pour des sollicitations en cisaillement
  selon l'axe :math:`z`, donnant l'effort tranchant :math:`F_z`
  en fonction du déplacement :math:`U_z` (pour les éléments **TIMO** seulement).

On ne peut définir qu'une seule loi de flexion (**FLXY** ou bien **FLXZ**) et qu'une seule loi
de cisaillement (**CISY** ou **CISZ**).

Les courbes doivent décrire les lois depuis les valeurs négatives (2 ou 3 points)
jusqu'aux valeurs positives (2 ou 3 points), en passant par l'origine, soit 5 ou 7 points au
total.





Loi CISAIL_NL
-------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de poutre **TIMO**.

Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne   'ELASTIQUE' 'PLASTIQUE' 'CISAIL_NL' 'TIMO' ;
   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'CISAIL_NL' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable avec adoucissement pour l'effort tranchant.

- Pour les éléments finis poutre **TIMO** : il s'agit d'une loi reliant l'effort tranchant
  au cisaillement :math:`F_z(\Gamma_z)` (en 3D) ou :math:`F_y(\Gamma_y)` (en 2D).
- Pour les éléments de section (**QUAS** **TRIS** **SEGS** **POJS**) : il s'agit d'une loi reliant
  la contrainte tangentielle au cisaillement :math:`\sigma_{xz}(\gamma_{xz})` (en 3D) ou :math:`\sigma_{xy}(\gamma_{xy})` (en 2D).

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est décrite dans :

**D. Combescure, P. Pegon,** *Introduction of two new global models in Castem 2000 for
seismic analysis of civil engineering structures*, JRC Special Publication N°I.96.34, Ispra, April **1996**.

**D. Combescure,** *Modélisation du comportement sismique des structures portiques
comportant des murs de remplissage*. Thèse de doctorat ECP préparée au JRC Ispra, Octobre **1996**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **DELP**: déformation limite du domaine élastique (sens positif)
- **DELN**: déformation limite du domaine élastique (sens négatif)
- **DMAP** : endommagement maximum lors de la plastification (sens positif)
- **DMAN**: endommagement maximum lors de la plastification (sens négatif)
- **BETA**: paramètre de pincement sous chargement cyclique

  - si **BETA** = 1, il n'y a pas de pincement
  - si **BETA** = 0, le modèle est similaire à un modèle de glissement

- **ALFA**: paramètre réglant la vitesse de la dégradation de résistance sous chargement cyclique
- **TETA**: fraction de la résistance résiduelle après complète dégradation sous chargement
  cyclique
- **MONP**: évolution de l'effort tranchant (ou de la contrainte de cisaillement) en fonction de la
  déformation plastique (déformation positive)
- **MONN** : évolution de l'effort tranchant (ou de la contrainte de cisaillement) en fonction de la
  déformation plastique (déformation négative)




Loi INFILL_UNI
--------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'INFILL_UNI' 'BARR' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable unilatérale en traction/compression :math:`F_x(E_x)`.
La résistance en traction est nulle et le comportement en compression est décrit par
une courbe multi-linéaire avec possiblement de l'adoucissement.

Cette loi peut être utilisée sur deux éléments de barre comme modèle global
pour modéliser les murs de remplissage en maçonnerie.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est décrite dans :

**D. Combescure, P. Pegon,** *Introduction of two new global models in Castem 2000 for
seismic analysis of civil engineering structures*, JRC Special Publication N°I.96.34, Ispra, April **1996**.

**D. Combescure,** *Modélisation du comportement sismique des structures portiques
comportant des murs de remplissage*. Thèse de doctorat ECP préparée au JRC Ispra, Octobre **1996**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **DELA** : déformation limite du domaine élastique
- **DMAX** : endommagement maximal lors de la plastification
- **BETA** : parametre de pincement
- **GAMM** : paramètre réglant la position du point de fin de glissement et de début de rechargement
- **GAMP** : paramètre réglant la position du point de fin de glissement et de début de rechargement
- **ALFA** : paramètre réglant la vitesse de la dégradation de résistance sous chargement cyclique
- **TETA** : fraction de la résistance résiduelle après complète dégradation sous chargement cyclique
- **MONO** : évolution de l'effort normal :math:`F_x` de compression (ici compté positivement) en fonction
  de la deformation axiale plastique :math:`E_x`






Loi INFILL_UNI
--------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne 'ELASTIQUE' 'PLASTIQUE' 'INFILL_UNI' 'BARR' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable unilatérale en traction/compression :math:`F_x(E_x)`.
La résistance en traction est nulle et le comportement en compression est décrit par
une courbe multi-linéaire avec possiblement de l'adoucissement.

Cette loi peut être utilisée sur deux éléments de barre comme modèle global
pour modéliser les murs de remplissage en maçonnerie.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est décrite dans :

**D. Combescure, P. Pegon,** *Introduction of two new global models in Castem 2000 for
seismic analysis of civil engineering structures*, JRC Special Publication N°I.96.34, Ispra, April **1996**.

**D. Combescure,** *Modélisation du comportement sismique des structures portiques
comportant des murs de remplissage*. Thèse de doctorat ECP préparée au JRC Ispra, Octobre **1996**.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **DELA** : déformation limite du domaine élastique
- **DMAX** : endommagement maximal lors de la plastification
- **BETA** : parametre de pincement
- **GAMM** : paramètre réglant la position du point de fin de glissement et de début de rechargement
- **GAMP** : paramètre réglant la position du point de fin de glissement et de début de rechargement
- **ALFA** : paramètre réglant la vitesse de la dégradation de résistance sous chargement cyclique
- **TETA** : fraction de la résistance résiduelle après complète dégradation sous chargement cyclique
- **MONO** : évolution de l'effort normal :math:`F_x` de compression (ici compté positivement) en fonction
  de la deformation axiale plastique :math:`E_x`




Loi BETON_BAEL
--------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne   'ELASTIQUE' 'PLASTIQUE' 'BETON_BAEL' 'BARR' ;
   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'BETON_BAEL' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique uniaxiale unilatérale en traction/compression
:math:`\sigma_{xx}(\varepsilon_{xx})`.

La résistance en traction est nulle et le comportement en compression est décrit par
une loi parabolique jusqu'au pic, puis un plateau de plasticité.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est issue des règles de calcul du BAEL :
**BAEL 91** *Règles techniques de conception et de calcul des ouvrages et constructions en
béton armé suivant la méthode des états ultimes*, **1992**

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **FC** : résistance en compression






Loi BETON_UNI
-------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne   'ELASTIQUE' 'PLASTIQUE' 'BETON_UNI' 'BARR' ;
   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'BETON_UNI' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élasto-plastique endommageable uniaxiale en traction/compression
avec adoucissement :math:`\sigma_{xx}(\varepsilon_{xx})` suivant le modèle de Hognestad avec
possibilité de prendre en compte le confinement apporté par les cadres.

Elle permet de reproduire :

- l'adoucissement après fissuration,
- le comportement unilatéral du béton (refermeture des fissures),
- l'adoucissement après avoir atteint la résistance en compression,
- la prise en compte du confinement sur cet adoucissement et la résistance en compression.

Deux fonctionnements d'ouverture et refermeture de fissures sont possibles (raide et souple).

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est décrite dans :

**E. Hognestad** *A study of combined bending and axial load in reinforced concrete*,
Bulletin Series 339, Univ. of Illinois, **1951**

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Paramètres pour la courbe de compression (loi parabole puis adoucissement linéaire) :

- **STFC** :  containte de compression au pic
- **EZER** :  deformation de compression au pic
- **ZETA** :  pente de la partie descendante de la courbe de compression
- **ST85** :  plateau de la courbe de compression

Paramètres pour la prise en compte du confinement en compression :

- **ALF1** :  parametre de confinement
- **OME1** :  parametre de confinement

Paramètres pour la courbe de traction (loi linéaire puis ) :

- **STFT** :  contrainte de traction au pic
- **TRAF** :  facteur definissant l'adoucissement de traction
- **STPT** :  contrainte residuelle en traction

Paramètres définissant la courbe de fermeture et d'ouverture de la fissure :

- **FAMX** :  facteur F1 (definissant le point de refermeture), doit etre positif pour avoir un sens physique.
  Si négatif, la loi de fermeture de fissure raide est prise et les parametres
  **STPT**, **FAMX**, **FACL**, **FAM1** et **FAM2** ne sont pas pris en compte par le modèle
- **FACL** :  facteur F2 (définissant le point d'ouverture complète)
- **FAM1** :  facteur F1'(définissant la pente associée a F1)
- **FAM2** :  facteur F2'(définissant la pente associée a F2)






Loi FRAGILE_UNI
---------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne   'ELASTIQUE' 'PLASTIQUE' 'FRAGILE_UNI' 'BARR' ;
   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'FRAGILE_UNI' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élastique endommageable uniaxiale en traction/compression
:math:`\sigma_{xx}(\varepsilon_{xx})`.

Les courbes d'endommagement en traction et compression sont indépendantes.
Elles suivent une fonction hyperbolique avec possibilité de contrainte résiduelle
et sont proches du modèles de Mazars.

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **FC** : résistance en compression
- **FC_R** : contrainte résiduelle en compression
- **STRC** : déformation contrôlant l'adoucissement en compression
- **FT** : résistance en traction
- **FT_R** : contrainte résiduelle en traction
- **STRT** : déformation contrôlant l'adoucissement en traction






Loi UNILATERAL
--------------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi globale, pour les éléments finis de barre **BARR**.

Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_ligne   'ELASTIQUE' 'PLASTIQUE' 'UNILATERAL' 'BARR' ;
   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'UNILATERAL' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élastique endommageable uniaxiale unilatéral en traction/compression
:math:`\sigma_{xx}(\varepsilon_{xx})` selon le modèle de Laborderie.

Ce modèle permet de reproduire la reprise de raideur lors de la refermeture des fissures.
Il possède deux variables d'endommagement séparées pour la traction et la compression.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette loi est décrite dans :

**Ch. La Borderie** *Phénomènes unilatéraux dans un matériau endommageable :
modélisation et application à l'analyse de structures en béton*, Thèse de doctorat
de l'ENS Cachan, **1991**

**J.F. Dubé** *Modélisation Simplifiée et Comportement Visco-Endommageable des Structures
en Béton*, Thèse de doctorat de l'ENS Cachan, Décembre **1994**

**P. Kotronis** *Cisaillement dynamique de murs en béyon armé. Modèles simplifiés 2D et 3D*,
Thèse de doctorat de l'ENS Cachan, Décembre **2000**

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **YS1** : seuil en énergie pour la traction
- **YS2** : seuil en énergie pour la compression
- **A1** : paramètre pour la traction
- **B1** : paramètre pour la traction
- **A2** : paramètre pour la compression
- **B2** : paramètre pour la compression
- **BET1** : gère les déformations inélastiques en traction
- **BET2** : gère les déformations inélastiques en compression
- **SIGF** : contrainte de refermeture de fissures







Loi MAZARS
----------

Type d'éléments finis
~~~~~~~~~~~~~~~~~~~~~
Loi semi-globale, pour les éléments finis de section (poutre à fibre) **QUAS**, **TRIS**, **SEGS**, **POJS**.


Mots clefs dans l'opérateur MODE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: gibiane

   MODE mail_section 'ELASTIQUE' 'PLASTIQUE' 'MAZARS' 'QUAS'/'TRIS'/'SEGS'/'POJS' ;

Description
~~~~~~~~~~~
Loi de comportement élastique endommageable en traction/compression
:math:`\sigma_{xx}(\varepsilon_{xx})` selon le modèle de Mazars.

L'endommagement est représenté par une seule variable scalaire.

Dans cette version pour les poutres à fibres, l'endommagement est également reporté sur
les contraintes tangentielles (comme dans la version 3D du modèle). Ceci permet d'avoir un
comportement non linéaire en cisaillement et d'assouplir le comportement à l'effort tranchant.

Références bibliographiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~
La déclinaison de loi 3D de Mazars pour les poutres multifibres est décrite dans :

**D. Combescure, P. Pegon** *A Fiber Model accounting for Transverse Shear in Castem 2000*,
JRC Special Publication N°I.94.59, Ispra, **1994**

Paramètres de la loi non linéaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **KTR0**: seuil en déformation pour la traction
- **ACOM**: paramètre pour la compression
- **BCOM**: paramètre pour la compression
- **ATRA**: paramètre pour la traction
- **BTRA**: paramètre pour la traction
- **BETA**: correction pour le cisaillement


*TODO : modèles RICBET_UNI, STRUT_UNI ? Modèles pour aciers, ancrages et recouvrements*
