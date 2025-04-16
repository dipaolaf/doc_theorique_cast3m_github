.. _sec:modeles_beton_verif:

Vérification
============

Ce chapitre présente la démarche de vérification élémentaire pour l'ensemble des lois de comportement pour
le béton disponibles dans Cast3M. Pour chaque loi de comportement y sont décrit :

- les cas de chargement appliqués (selon la :ref:`spécification des tests <sec:modeles_beton_tests>`) ;
- les phénomènes observés ;
- la solution de référence ;
- les résultats et leur comparaison à la référence.



Pour les tests unitaires, c'est-à-dire portant sur un seul élément fini, la géométrie considérée est toujours :

- en 3D/2D poutre à fibres : 1 élément **TIMO** avec :math:`L=1` m et 1 élément **QUAS** de section carré avec :math:`S=1` m² [nh145313 : actuellement :math:`S=10^{-2}` m²];
- en 3D volumique : 1 élément **CUB8** avec :math:`L=1` m ;
- en 2D contraintes planes : 1 élément **QUA4** avec :math:`L=1` m et :math:`e=0,1` m (paramètre **DIM3**) ;
- en 2D axisymétrique : 1 élément **QUA4** avec :math:`R=1` m et :math:`H=1` m.



Loi MAZARS
----------

.. _sec:mazars_ana_trac:

Traction monotone
~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_traction.dgibi``

On applique le cas de chargement de traction simple pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_trac_mono>`
et :ref:`massif <sec:modeles_beton_test_mass_trac_mono>` en déplacement imposé croissant jusqu’à atteindre l’endommagement autour de 0,9.

Pour tous les modes de calcul le déplacement imposé vaut :math:`u_{max}=5.10^{-4}` m.

L’objectif est d’évaluer la limite en traction puis le comportement post-pic du modèle.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Solution de référence
+++++++++++++++++++++
La solution de référence est obtenue de manière analytique à partir de l'équation donnant la loi de l'évolution de l'endommagement en traction.

Endommagement
"""""""""""""

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{e} - A_t\exp\left[-B_t (e - e_0)\right]
   
où :

- :math:`A_t` et :math:`B_t` sont les paramètres de la loi de Mazars en traction ;
- :math:`e_0` est le seuil d'endommagement en déformation ;
- :math:`e` est la déformation équivalente selon la formulation proposée par Mazars :

.. math::
   {e} = \sqrt{\sum_{i=1}^{^{n}}\langle\epsilon_{i}\rangle^{2}}
   
où :math:`\langle\epsilon_{i}\rangle` est la partie positive de la i-ème déformation principale et :math:`n` répresente la dimension du problème consideré (cf. chapitre :ref:`mazars`).
   
L'expression de la déformation équivalente :math:`e` dépend du mode de représentation géométrique (choix de modélisation E.F. et dimension spatiale) et doit donc être spécifiée dans chaque cas.

Contrainte
""""""""""
Pour un problème en déplacement imposé (i.e. en déformation imposée dans la cas présent unitaire géométrique), l'expression de la contrainte se déduit de la relation contrainte-déformation et de l'expression de l'endommagement :

.. math::

   \boldsymbol{\sigma} = (1-D_{t}) \mathbb{E} : \boldsymbol{\varepsilon}

Ecart entre résultat de calcul et solution de référence
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
L'écart entre la contrainte calculée et la solution de référence est évalué via l'aire sous la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)`, dont l'abscisse est strictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

.. math::
   |Ec.rel.\sigma_{xx}| = \frac{\left|\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}\right|} {\sigma_{xx_{ref.}}}

Pour chaque configuration traîtée, on fournit une valeur scalaire quantitative de l'écart qui correspond à la moyenne intégrale de la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)` définie par :
 
.. math::
   Moy.int. = \frac{1}{t_{2}-t_{1}}\sum_{t_{1}}^{^{t_{2}}}|Ec.rel.\sigma_{xx}|\Delta t
   
où :math:`[t_{1};t_{2}]` est l'intersection du domaine de définition temporel de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
Dans la source fibmaz.eso décrivant le modèle Mazars pour la poutre à fibres, quelque soit la dimension géométrique du problème, le tenseur des déformations est défini en 3D de la façon suivante :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & \epsilon_{xy} & \epsilon_{xz} \\
         \epsilon_{xy} & -\nu\epsilon_{xx} & 0 \\
         \epsilon_{xz} & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Or, la traction est uniaxiale dans la direction :math:`x`, donc :math:`\epsilon_{xy}=\epsilon_{xz}=0`, d'où :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}>0` (traction), on a :

- :math:`\langle\epsilon_{xx}\rangle=\epsilon_{xx}`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}<0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=0`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\epsilon_{xx}

On en déduit la solution de référence de l'endommagement :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

Puis la solution de référence de la contrainte dans la direction de la poutre :

.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   4,70084.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
Dans la mesure où le tenseur des déformations est défini en 3D dans le modèle Mazars pour la poutre à fibres, son expression dans le cas 2D est la même que dans le cas 3D :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & \epsilon_{xy} & \epsilon_{xz} \\
         \epsilon_{xy} & -\nu\epsilon_{xx} & 0 \\
         \epsilon_{xz} & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Or, la traction est uniaxiale dans la direction :math:`x`, donc :math:`\epsilon_{xy}=\epsilon_{xz}=0`, d'où :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}>0` (traction), on a :

- :math:`\langle\epsilon_{xx}\rangle=\epsilon_{xx}`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}<0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=0`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\epsilon_{xx}

On en déduit la solution de référence de l'endommagement :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

Puis la solution de référence de la contrainte dans la direction de la poutre :

.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   4,70084.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La traction est uniaxiale dans la direction :math:`x`, d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}>0` (traction), on a :

- :math:`\langle\epsilon_{xx}\rangle=\epsilon_{xx}`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}<0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=0`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\epsilon_{xx}

On en déduit la solution de référence de l'endommagement :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`x` :

.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,46384.10^{-15} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La traction est uniaxiale dans la direction :math:`x` et, en contraintes planes, la déformation est libre dans la direction :math:`z` orthogonale au plan de représentation géométrique 2D (contration par effet de Poisson), d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}>0` (traction), on a :

- :math:`\langle\epsilon_{xx}\rangle=\epsilon_{xx}`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}<0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=0`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\epsilon_{xx}

On en déduit la solution de référence de l'endommagement :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`x` :

.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,15463.10^{-15} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La traction est uniaxiale dans la direction :math:`z`, d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         -\nu\epsilon_{zz} & 0 & 0 \\
         0 & -\nu\epsilon_{zz} & 0 \\
         0 & 0 & \epsilon_{zz}
      \end{bmatrix}

Sachant que :math:`\epsilon_{zz}>0` (traction), on a :

- :math:`\epsilon_{rr}=\epsilon_{\theta\theta}=-\nu\epsilon_{zz}<0`, donc :math:`\langle\epsilon_{rr}\rangle=\langle\epsilon_{\theta\theta}\rangle=0`
- :math:`\langle\epsilon_{zz}\rangle=\epsilon_{zz}`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{rr}\rangle^{2}+\langle\epsilon_{\theta\theta}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\epsilon_{zz}

On en déduit la solution de référence de l'endommagement :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{zz}} - A_t\exp\left[-B_t (\epsilon_{zz} - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`z` :

.. math::
   \sigma_{zz}=(1-D_t) E \epsilon_{zz}

Dans Cast3M, 

- :math:`\epsilon_{zz}` correspond à la composante ``'EPZZ'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{zz}` correspond à la composante ``'SMZZ'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,39061.10^{-15} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_mono_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



.. _sec:mazars_ana_comp:

Compression monotone
~~~~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_compression.dgibi``

On applique le cas de chargement de compression simple pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_comp_mono>` et :ref:`massif <sec:modeles_beton_test_mass_comp_mono>` en déplacement imposé négatif, croissant en valeur absolue, jusqu’à atteindre l’endommagement autour de 0,9.

Pour tous les modes de calcul le déplacement imposé vaut :math:`u_{max}=-5.10^{-3}` m.

L’objectif est d’évaluer la limite en compression puis le comportement post-pic du modèle.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Solution de référence
+++++++++++++++++++++
La solution de référence est obtenue de manière analytique à partir de l'équation donnant la loi de l'évolution de l'endommagement en compression.

Endommagement
"""""""""""""

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{e} - A_c\exp\left[-B_c (e - e_0)\right]
   
où :

- :math:`A_c` et :math:`B_c` sont les paramètres de la loi de Mazars en compression ;
- :math:`e_0` est le seuil d'endommagement en déformation ;
- :math:`e` est la déformation équivalente selon la formulation proposée par Mazars :

.. math::
   {e} = \sqrt{\sum_{i=1}^{^{n}}\langle\epsilon_{i}\rangle^{2}}
   
où :math:`\langle\epsilon_{i}\rangle` est la partie positive de la i-ème déformation principale et :math:`n` répresente la dimension du problème consideré (cf. chapitre :ref:`mazars`).
   
L'expression de la déformation équivalente :math:`e` dépend du mode de représentation géométrique (choix de modélisation E.F. et dimension spatiale) et doit donc être spécifiée dans chaque cas.

Contrainte
""""""""""
Pour un problème en déplacement imposé (i.e. en déformation imposée dans la cas présent unitaire géométrique), l'expression de la contrainte se déduit de la relation contrainte-déformation et de l'expression de l'endommagement :

.. math::

   \boldsymbol{\sigma} = (1-D_{t}) \mathbb{E} : \boldsymbol{\varepsilon}

Ecart entre résultat de calcul et solution de référence
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
L'écart entre la contrainte calculée et la solution de référence est évalué via l'aire sous la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)`, dont l'abscisse est strictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

.. math::
   |Ec.rel.\sigma_{xx}| = \left|\frac{\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}} {\sigma_{xx_{ref.}}}\right|

Pour chaque configuration traîtée, on fournit une valeur scalaire quantitative de l'écart qui correspond à la moyenne intégrale de la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)` définie par :
 
.. math::
   Moy.int. = \frac{1}{t_{2}-t_{1}}\sum_{t_{1}}^{^{t_{2}}}|Ec.rel.\sigma_{xx}|\Delta t
   
où :math:`[t_{1};t_{2}]` est l'intersection du domaine de définition temporel de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
Dans la source fibmaz.eso décrivant le modèle Mazars pour la poutre à fibres, quelque soit la dimension géométrique du problème, le tenseur des déformations est défini en 3D de la façon suivante :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & \epsilon_{xy} & \epsilon_{xz} \\
         \epsilon_{xy} & -\nu\epsilon_{xx} & 0 \\
         \epsilon_{xz} & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Or, la compression est uniaxiale dans la direction :math:`x`, donc :math:`\epsilon_{xy}=\epsilon_{xz}=0`, d'où :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}<0` (compression), on a :

- :math:`\langle\epsilon_{xx}\rangle=0`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}>0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=-\nu\epsilon_{xx}`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\sqrt{2}\nu|\epsilon_{xx}|

On en déduit la solution de référence de l'endommagement :

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]

Puis la solution de référence de la contrainte dans la direction de la poutre :

.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,39960.10^{-9} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
Dans la mesure où le tenseur des déformations est défini en 3D dans le modèle Mazars pour la poutre à fibres, son expression dans le cas 2D est la même que dans le cas 3D :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & \epsilon_{xy} & \epsilon_{xz} \\
         \epsilon_{xy} & -\nu\epsilon_{xx} & 0 \\
         \epsilon_{xz} & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Or, la compression est uniaxiale dans la direction :math:`x`, donc :math:`\epsilon_{xy}=\epsilon_{xz}=0`, d'où :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}<0` (compression), on a :

- :math:`\langle\epsilon_{xx}\rangle=0`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}>0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=-\nu\epsilon_{xx}`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\sqrt{2}\nu|\epsilon_{xx}|

On en déduit la solution de référence de l'endommagement :

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]

Puis la solution de référence de la contrainte dans la direction de la poutre :

.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,39960.10^{-9} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La compression est uniaxiale dans la direction :math:`x`, d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}<0` (compression), on a :

- :math:`\langle\epsilon_{xx}\rangle=0`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}>0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=-\nu\epsilon_{xx}`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\sqrt{2}\nu|\epsilon_{xx}|

On en déduit la solution de référence de l'endommagement :

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`x` :

.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   6,94087.10^{-10} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La compression est uniaxiale dans la direction :math:`x` et, en contraintes planes, la déformation est libre dans la direction :math:`z` orthogonale au plan de représentation géométrique 2D (expansion par effet de Poisson), d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         \epsilon_{xx} & 0 & 0 \\
         0 & -\nu\epsilon_{xx} & 0 \\
         0 & 0 & -\nu\epsilon_{xx}
      \end{bmatrix}

Sachant que :math:`\epsilon_{xx}<0` (compression), on a :

- :math:`\langle\epsilon_{xx}\rangle=0`
- :math:`\epsilon_{yy}=\epsilon_{zz}=-\nu\epsilon_{xx}>0`, donc :math:`\langle\epsilon_{yy}\rangle=\langle\epsilon_{zz}\rangle=-\nu\epsilon_{xx}`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{xx}\rangle^{2}+\langle\epsilon_{yy}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\sqrt{2}\nu|\epsilon_{xx}|

On en déduit la solution de référence de l'endommagement :

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`x` :

.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   5,04719.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""
La compression est uniaxiale dans la direction :math:`z`, d'où l'expression du tenseur des déformations :

.. math::

   \boldsymbol{\epsilon} = 
      \begin{bmatrix}
         -\nu\epsilon_{zz} & 0 & 0 \\
         0 & -\nu\epsilon_{zz} & 0 \\
         0 & 0 & \epsilon_{zz}
      \end{bmatrix}

Sachant que :math:`\epsilon_{zz}<0` (compression), on a :

- :math:`\epsilon_{rr}=\epsilon_{\theta\theta}=-\nu\epsilon_{zz}>0`, donc :math:`\langle\epsilon_{rr}\rangle=\langle\epsilon_{\theta\theta}\rangle=-\nu\epsilon_{zz}`
- :math:`\langle\epsilon_{zz}\rangle=0`

La déformation équivalente s'exprime donc par :

.. math::
   {e} = \sqrt{\langle\epsilon_{rr}\rangle^{2}+\langle\epsilon_{\theta\theta}\rangle^{2}+\langle\epsilon_{zz}\rangle^{2}}=\sqrt{2}\nu|\epsilon_{zz}|

On en déduit la solution de référence de l'endommagement :

.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{zz}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{zz}| - e_0)\right]

Puis la solution de référence de la contrainte dans la direction :math:`z` :

.. math::
   \sigma_{zz}=(1-D_c) E \epsilon_{zz}

Dans Cast3M, 

- :math:`\epsilon_{zz}` correspond à la composante ``'EPZZ'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{zz}` correspond à la composante ``'SMZZ'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   4,21894.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_mono_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Traction cyclique
~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_traction_cyclique.dgibi``

On applique le cas de chargement de traction simple pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_trac_cycl>`
et :ref:`massif <sec:modeles_beton_test_mass_trac_cycl>` en déplacement imposé entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur du déplacement au pic augmente progressivement jusqu’à atteindre l’endommagement autour de 0,9.

Pour tous les modes de calcul le déplacement imposé vaut :math:`u_{max}=5.10^{-4}` m.

On choisit l'incrément du déplacement au pic de chaque cycle de façon à ce que le seuil d'endommagement soit franchi à chaque fois. Le module élastique est alors multiplié par :math:`(1 - D_{e})`, où :math:`D_{e}` est l'endommagement élémentaire consécutif à chaque franchissement du seuil. Il en résulte une diminution du module élastique avec l'endommagement. Du fait de l'accroissement du déplacement au pic des cycles, l'endommagement s'accroit, ce qui conduit à une diminution du module élastique.

L’objectif est de vérifier la dégradation progressive des propriétés mécaniques du matériau au cours du chargement via la diminution du module élastique à chaque cycle.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Pour chaque configuration géométrique, la solution de référence est identique à celle décrite dans le chapitre :ref:`Traction monotone <sec:mazars_ana_trac>`.

L'écart entre la contrainte calculée et la solution de référence est également évalué de la même façon : il s'agit de la moyenne intégrale de la courbe d'évolution temporelle de la valeur absolue de l'écart relatif entre les contraintes calculée et de référence.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   6,55083.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction_cyclique.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   6,55083.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction_cyclique.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,63380.10^{-15} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction_cyclique.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   8,07811.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction_cyclique.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   3,28864.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_traction_cyclique.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_cycl_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Compression cyclique
~~~~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_compression_cyclique.dgibi``

On applique le cas de chargement de compression simple pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_comp_cycl>` et :ref:`massif <sec:modeles_beton_test_mass_comp_cycl>` en déplacement imposé négatif entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur absolue du déplacement au pic augmente progressivement jusqu’à atteindre l’endommagement autour de 0,9.

Pour tous les modes de calcul le déplacement imposé vaut :math:`u_{max}=-5.10^{-3}` m.

On choisit l'incrément du déplacement au pic de chaque cycle de façon à ce que le seuil d'endommagement soit franchi à chaque fois. Le module élastique est alors multiplié par :math:`(1 - D_{e})`, où :math:`D_{e}` est l'endommagement élémentaire consécutif à chaque franchissement du seuil. Il en résulte une diminution du module élastique avec l'endommagement. Du fait de l'accroissement de la valeur absolue du déplacement au pic des cycles, l'endommagement s'accroit, ce qui conduit à une diminution du module élastique.

L’objectif est de vérifier la dégradation progressive des propriétés mécaniques du matériau au cours du chargement via la diminution du module élastique à chaque cycle.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Pour chaque configuration géométrique, la solution de référence est identique à celle décrite dans le chapitre :ref:`Compression monotone <sec:mazars_ana_comp>`.

L'écart entre la contrainte calculée et la solution de référence est également évalué de la même façon : il s'agit de la moyenne intégrale de la courbe d'évolution temporelle de la valeur absolue de l'écart relatif entre les contraintes calculée et de référence.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   3,70109.10^{-11} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression_cyclique.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   3,70109.10^{-11} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression_cyclique.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,11598.10^{-9} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression_cyclique.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   8,30071.10^{-16} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression_cyclique.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

On observe que :

- La solution calculée (parties linéaires rouges) reproduit correctement la diminution à chaque cycle du module élastique prévue par la solution de référence (parties linéaires bleues) ;
- La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

.. math::
   1,41884.10^{-15} < 1.10^{-6}
   
En conséquence, les résultats du cas-test ``mazars_compression_cyclique.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_comp_cycl_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Traction compression
~~~~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_traction_compression.dgibi``

On applique le cas de chargement de traction compression alternées pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_trac_comp>`
et :ref:`massif <sec:modeles_beton_test_mass_trac_comp>` en déplacement imposé croissant en valeur absolue (positif en traction, puis négatif en compression) jusqu’à atteindre l’endommagement autour de 0,9.

Pour tous les modes de calcul le déplacement imposé vaut, en traction :math:`u_{tmax}=2.10^{-4}` m et en compression :math:`u_{cmax}=-5.10^{-3}` m.

L’objectif est de vérifier, lorsque le chargement passe de la traction à la compression pendant le calcul, que le modèle commute correctement d'un mode d'endommagement à l'autre.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Solution de référence
+++++++++++++++++++++
La solution de référence est obtenue de manière analytique à partir des équations donnant la loi de l'évolution de l'endommagement en traction et en compression. Ces deux lois sont fonctions de la déformation équivalente selon la formulation de Mazars qui est dépendante du mode de chargement et du mode de représentation géométrique.

Ecart entre résultat de calcul et solution de référence
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
L'écart entre la contrainte calculée et la solution de référence est évalué, d'une part pour la phase de traction et d'autre part pour la phase de compression, via l'aire sous la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)`, dont l'abscisse est strictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

- Pour la phase de traction :

.. math::
   |Ec.rel.\sigma_{xx}| = \frac{\left|\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}\right|} {\sigma_{xx_{ref.}}}

- Pour la phase de compression :

.. math::
   |Ec.rel.\sigma_{xx}| = \left|\frac{\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}} {\sigma_{xx_{ref.}}}\right|

Pour chaque configuration traîtée, on fournit deux valeurs scalaires quantitatives de l'écart (une pour la phase de traction et l'autre pour la phase de compression) qui correspondent à la moyenne intégrale dans chacune des deux phases de la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)` définie par :

.. math::
   Moy.int. = \frac{1}{t_{2}-t_{1}}\sum_{t_{1}}^{^{t_{2}}}|Ec.rel.\sigma_{xx}|\Delta t
   
où, dans chacune des deux phases, :math:`[t_{1};t_{2}]` est l'intersection du domaine de définition temporel de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`4,23809.10^{-16} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`1,33474.10^{-9} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- en traction : :math:`4,23809.10^{-16} < 1.10^{-6}` ;
- en compression : :math:`1,33474.10^{-9} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- en traction : :math:`2,77131.10^{-16} < 1.10^{-6}` ;
- en compression : :math:`2,06023.10^{-10} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- en traction : :math:`1,76859.10^{-16} < 1.10^{-6}` ;
- en compression : :math:`5,38924.10^{-16} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction (:math:`\epsilon_{zz}>0`) : :math:`e=\epsilon_{zz}` ;
- en compression (:math:`\epsilon_{zz}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{zz}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction (:math:`\epsilon_{zz}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{zz}} - A_t\exp\left[-B_t (\epsilon_{zz} - e_0)\right]

- en compression (:math:`\epsilon_{zz}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{zz}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{zz}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction (:math:`\epsilon_{zz}>0`) :
   
.. math::
   \sigma_{zz}=(1-D_t) E \epsilon_{zz}

- en compression (:math:`\epsilon_{zz}<0`) :
   
.. math::
   \sigma_{zz}=(1-D_c) E \epsilon_{zz}

Dans Cast3M, 

- :math:`\epsilon_{zz}` correspond à la composante ``'EPZZ'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{zz}` correspond à la composante ``'SMZZ'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- en traction : :math:`2,20339.10^{-16} < 1.10^{-6}` ;
- en compression : :math:`5,43269.10^{-16} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Traction compression traction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_traction_compression_traction.dgibi``

On applique le cas de chargement de traction compression traction alternées pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_trac_comp_trac>`
et :ref:`massif <sec:modeles_beton_test_mass_trac_comp_trac>` en déplacement imposé dont la valeur absolue est croissante dans chacun des sens, jusqu’à atteindre un endommagement supérieur à 0,95.

Pour tous les modes de calcul, le déplacement imposé maximum vaut, dans la première phase de traction :math:`u_{t1max}=2.10^{-4}` m, dans la deuxième phase de  compression :math:`u_{c2max}=-4.10^{-3}` m, puis dans la troisième phase de traction :math:`u_{t3max}=5.10^{-4}` m.

L’objectif est de vérifier, lorsque le chargement passe pendant le calcul de la traction à la compression puis à nouveau à la traction, que le modèle commute correctement d'un mode d'endommagement à l'autre.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs ;
- de la force de réaction globale en fonction du déplacement imposé.

Solution de référence
+++++++++++++++++++++
La solution de référence est obtenue de manière analytique à partir des équations donnant la loi de l'évolution de l'endommagement en traction et en compression. Ces deux lois sont fonctions de la déformation équivalente selon la formulation de Mazars qui est dépendante du mode de chargement et du mode de représentation géométrique.

Ecart entre résultat de calcul et solution de référence
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
L'écart entre la contrainte calculée et la solution de référence est évalué, pour la phase 1 de traction, pour la phase 2 de compression puis pour la phase 3 de traction, via l'aire sous la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)`, dont l'abscisse est strictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

- Pour les phases 1 et 3 de traction :

.. math::
   |Ec.rel.\sigma_{xx}| = \frac{\left|\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}\right|} {\sigma_{xx_{ref.}}}

- Pour la phase 2 de compression :

.. math::
   |Ec.rel.\sigma_{xx}| = \left|\frac{\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}} {\sigma_{xx_{ref.}}}\right|

Pour chaque configuration traîtée, on fournit trois valeurs scalaires quantitatives de l'écart (une pour la phase 1 de traction, une pour la phase 2 de compression et une pour la phase 3 de traction) qui correspondent à la moyenne intégrale dans chacune des trois phases de la courbe :math:`|Ec.rel.\sigma_{xx}|=f(temps)` définie par :

.. math::
   Moy.int. = \frac{1}{t_{2}-t_{1}}\sum_{t_{1}}^{^{t_{2}}}|Ec.rel.\sigma_{xx}|\Delta t
   
où, dans chacune des trois phases, :math:`[t_{1};t_{2}]` est l'intersection du domaine de définition temporel de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Solution de référence
"""""""""""""""""""""

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression, phase 2 (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`2,18349.10^{-16} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`1,89299.10^{-9} < 1.10^{-6}` ;
- dans la phase 3 de traction : :math:`1,89462.10^{-15} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression_traction.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_f_3dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression, phase 2 (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'VISXX'``, rebaptisée ci-dessous ``'EPXX'``, du sous-champs ``'VAIS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du sous-champs ``'VONS'`` du champs des variables internes ``TAB1.'VARIABLES_INTERNES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`2,18349.10^{-16} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`1,89299.10^{-9} < 1.10^{-6}` ;
- dans la phase 3 de traction : :math:`1,89462.10^{-15} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression_traction.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_f_2dpaf.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression, phase 2 (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`3,46471.10^{-16} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`3,66278.10^{-10} < 1.10^{-6}` ;
- dans la phase 3 de traction : :math:`9,92368.10^{-15} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression_traction.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) : :math:`e=\epsilon_{xx}` ;
- en compression, phase 2 (:math:`\epsilon_{xx}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{xx}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{xx}} - A_t\exp\left[-B_t (\epsilon_{xx} - e_0)\right]

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{xx}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{xx}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction, phases 1 et 3 (:math:`\epsilon_{xx}>0`) :
   
.. math::
   \sigma_{xx}=(1-D_t) E \epsilon_{xx}

- en compression, phase 2 (:math:`\epsilon_{xx}<0`) :
   
.. math::
   \sigma_{xx}=(1-D_c) E \epsilon_{xx}

Dans Cast3M, 

- :math:`\epsilon_{xx}` correspond à la composante ``'EPXX'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{xx}` correspond à la composante ``'SMXX'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`1,75501.10^{-16} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`4,62700.10^{-16} < 1.10^{-6}` ;
- dans la phase 3 de traction : :math:`1,92926.10^{-15} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression_traction.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_f_2dplan.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

On a montré précédemment que la déformation équivalente s'exprime par :

- en traction, phases 1 et 3 (:math:`\epsilon_{zz}>0`) : :math:`e=\epsilon_{zz}` ;
- en compression, phase 2 (:math:`\epsilon_{zz}<0`) : :math:`e=\sqrt{2}\nu|\epsilon_{zz}|`.

On en déduit les solutions de référence de l'endommagement :

- en traction, phases 1 et 3 (:math:`\epsilon_{zz}>0`) :

.. math::
   D_t = 1 - \frac{e_0 (1 - A_t)}{\epsilon_{zz}} - A_t\exp\left[-B_t (\epsilon_{zz} - e_0)\right]

- en compression, phase 2 (:math:`\epsilon_{zz}<0`) :
   
.. math::
   D_c = 1 - \frac{e_0 (1 - A_c)}{\sqrt{2}\nu|\epsilon_{zz}|} - A_c\exp\left[-B_c (\sqrt{2}\nu|\epsilon_{zz}| - e_0)\right]
   
Puis la solution de référence de la contrainte dans la direction de la poutre :

- en traction, phases 1 et 3 (:math:`\epsilon_{zz}>0`) :
   
.. math::
   \sigma_{zz}=(1-D_t) E \epsilon_{zz}

- en compression, phase 2 (:math:`\epsilon_{zz}<0`) :
   
.. math::
   \sigma_{zz}=(1-D_c) E \epsilon_{zz}

Dans Cast3M, 

- :math:`\epsilon_{zz}` correspond à la composante ``'EPZZ'`` du tenseur des déformations ``TAB.'DEFORMATIONS'`` en sortie de ``PASAPAS``.

- :math:`\sigma_{zz}` correspond à la composante ``'SMZZ'`` du tenseur des contraintes ``TAB1.'CONTRAINTES'`` en sortie de ``PASAPAS``.

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- dans la phase 1 de traction : :math:`5,96558.10^{-17} < 1.10^{-6}` ;
- dans la phase 2 de compression : :math:`4,04229.10^{-16} < 1.10^{-6}` ;
- dans la phase 3 de traction : :math:`8,41499.10^{-15} < 1.10^{-6}`.
   
En conséquence, les résultats du cas-test ``mazars_traction_compression_traction.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbe d'évolution de la force de réaction en fonction du déplacement imposé
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_trac_comp_trac_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Cisaillement
~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_cisaillement.dgibi``

On applique le cas de chargement de cisaillement simple pour les modélisations :ref:`poutre <sec:modeles_beton_test_pout_cisa_mono>`
et :ref:`massif <sec:modeles_beton_test_mass_cisa_mono>` en déformation imposée de cisaillement (glissement) croissante jusqu’à atteindre l’endommagement proche de 1.

Pour tous les modes de calcul, la déformation imposée vaut :math:`\gamma_{xy_{max}}=1,2.10^{-2}`.

L'objectif est d'évaluer l'impact du paramètre :math:`\beta>1` introduit dans le modèle de Mazars pour éviter une évolution trop rapide de l'endommagement en cisaillement (cf. chapitre :ref:`Formulation du modèle <sec:beta>`, [PIJAUDIER-1991]_). On compare les réponses obtenues avec amélioration (:math:`\beta=1,06`) et sans amélioration (:math:`\beta=1`) de la réponse en cisaillament.

L'analyse des résultats porte sur les courbes :

- d'endomagemment soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyen pour les modèles massifs, en fonction du temps ;
- de la contrainte en fonction de la déformation soit en chaque point de Gauss de la section de la poutre pour les modèles poutre à fibres, soit moyennes pour les modèles massifs.

On ne dispose pas de solution de référence pour ce cas-test.

Résultats du cas 3D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_d_3dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps - :math:`\beta=1`.

On observe que :

- L'évolution temporelle du dommage calculé avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) tend moins rapidement vers la valeur maximale :math:`D=1` que celle calculée avec :math:`\beta=1` (sans amélioration), ce qui correspond au bénéfice attendu de cette correction (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_s_3dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss - :math:`\beta=1`.

On observe que :

- En revanche, tandis que l'évolution de la contrainte en fonction de la déformation calculée avec :math:`\beta=1` (sans amélioration de la réponse en cisaillement) décroît pour les grandes valeurs de déformation (:math:`\sigma_{xy}=0` pour :math:`\gamma_{xy}>0,6`), celle calculée avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) se remet à croître au-delà de :math:`\gamma_{xy}>0,4`. Cette conséquence de la correction correspond à la reprise de rigidité à des niveaux de déformation élévée décrite dans les pathologies du modèle (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Le fait de retouver ces deux tendances attendues permet de conclure que les résultats du cas-test ``mazars_cisaillement.dgibi`` en mode 3D poutre à fibres sont jugés satisfaisants.

Résultats du cas 2D poutre à fibres
+++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_d_2dpaf.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps - :math:`\beta=1`.

On observe que :

- L'évolution temporelle du dommage calculé avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) tend moins rapidement vers la valeur maximale :math:`D=1` que celle calculée avec :math:`\beta=1` (sans amélioration), ce qui correspond au bénéfice attendu de cette correction (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_s_2dpaf.png
   :width: 15cm
   :align: center
   
   Contrainte en fonction de la déformation aux points de Gauss - :math:`\beta=1`.

On observe que :

- En revanche, tandis que l'évolution de la contrainte en fonction de la déformation calculée avec :math:`\beta=1` (sans amélioration de la réponse en cisaillement) décroît pour les grandes valeurs de déformation (:math:`\sigma_{xy}=0` pour :math:`\gamma_{xy}>0,6`), celle calculée avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) se remet à croître au-delà de :math:`\gamma_{xy}>0,4`. Cette conséquence de la correction correspond à la reprise de rigidité à des niveaux de déformation élévée décrite dans les pathologies du modèle (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Le fait de retouver ces deux tendances attendues permet de conclure que les résultats du cas-test ``mazars_cisaillement.dgibi`` en mode 2D poutre à fibres sont jugés satisfaisants.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps - :math:`\beta=1`.

On observe que :

- L'évolution temporelle du dommage calculé avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) tend moins rapidement vers la valeur maximale :math:`D=1` que celle calculée avec :math:`\beta=1` (sans amélioration), ce qui correspond au bénéfice attendu de cette correction (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne - :math:`\beta=1`.

On observe que :

- En revanche, tandis que l'évolution de la contrainte en fonction de la déformation calculée avec :math:`\beta=1` (sans amélioration de la réponse en cisaillement) décroît pour les grandes valeurs de déformation (:math:`\sigma_{xy}=0` pour :math:`\gamma_{xy}>0,6`), celle calculée avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) se remet à croître au-delà de :math:`\gamma_{xy}>0,4`. Cette conséquence de la correction correspond à la reprise de rigidité à des niveaux de déformation élévée décrite dans les pathologies du modèle (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Le fait de retouver ces deux tendances attendues permet de conclure que les résultats du cas-test ``mazars_cisaillement.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Courbe d'évolution de l'endommagement
"""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps - :math:`\beta=1`.

On observe que :

- L'évolution temporelle du dommage calculé avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) tend moins rapidement vers la valeur maximale :math:`D=1` que celle calculée avec :math:`\beta=1` (sans amélioration), ce qui correspond au bénéfice attendu de cette correction (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Courbe d'évolution de la contrainte en fonction de la déformation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Résultat avec amélioration de la réponse en cisaillement : :math:`\beta=1,06`.

.. figure:: figures/mazars_cisa_mono_beta1.06_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne - :math:`\beta=1,06`.

Résultat sans amélioration de la réponse en cisaillement : :math:`\beta=1`.

.. figure:: figures/mazars_cisa_mono_beta1_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne - :math:`\beta=1`.

On observe que :

- En revanche, tandis que l'évolution de la contrainte en fonction de la déformation calculée avec :math:`\beta=1` (sans amélioration de la réponse en cisaillement) décroît pour les grandes valeurs de déformation (:math:`\sigma_{xy}=0` pour :math:`\gamma_{xy}>0,6`), celle calculée avec :math:`\beta=1,06` (amélioration de la réponse en cisaillement) se remet à croître au-delà de :math:`\gamma_{xy}>0,4`. Cette conséquence de la correction correspond à la reprise de rigidité à des niveaux de déformation élévée décrite dans les pathologies du modèle (cf. chapitre :ref:`Formulation du modèle <sec:beta>`).

Le fait de retouver ces deux tendances attendues permet de conclure que les résultats du cas-test ``mazars_cisaillement.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

Enfin, on constate que les résultats sont identiques d'un mode de représentation géométrique à l'autre. La cohérence des résultats entre eux confirme qu'ils sont satisfaisants dans chaque mode de représentation.



Biaxial
~~~~~~~
Le cas-test se dénomme ``mazars_biaxial.dgibi``

On n'applique le cas de chargement de traction-compression biaxial que pour la modélisation :ref:`massif <sec:modeles_beton_test_mass_biax>`. En effet, la biaxialité du chargement n'a pas de sens avec la modélisation poutre à fibres qui ne traite que des chargements de type traction-compression dans la direction de la poutre et de cisaillement dans le plan de sa section.

Le chargement biaxial est en contraintes imposées croissante jusqu'à atteindre un endommagement proche de 1 (ruine complète).

Pour un calcul de valeur :math:`\theta` donnée, le chargement maximal est donné par :

.. math::
   \sigma_{xx}=\sigma_{max} \textrm{cos} \theta

.. math::
   \sigma_{yy}=\sigma_{max} \textrm{sin} \theta
   
avec :

.. math::
   \sigma_{max}=\frac{\sigma_{0}}{max(|cos\theta| ; |sin\theta|)}
   
- Pour le mode de calcul 3D volumique : :math:`\sigma_{0}=50~MPa`
- Pour le mode de calcul 2D contraintes planes : :math:`\sigma_{0}=5~MPa`
- Pour les deux modes de calcul, on définit 72 points de chargement en faisant varier :math:`\theta` dans le domaine :math:`[45°;225°]` avec un pas :math:`\Delta\theta=2,5°`. Les résultats de calcul sur la deuxième moitié du domaine angulaire sont obtenus par symétrie par rapport à la bissectrice.

.. figure:: figures/Figure_char_biaxial_180.png
   :width: 10cm
   :align: center
   
   Chargement biaxial du mode 3D volumique pour :math:`\theta \in [45°;225°]` (:math:`\sigma_{0}` en bleu, :math:`\sigma_{max}` en vert). Les résultats de la deuxième moitié du domaine angulaire sont obtenus par symétrie par rapport à la bissectrice.

Pour chaque valeur de :math:`\theta`, le calcul est interrompu avant d'atteindre le chargement maximal, lors de la détection de la ruine qui résulte de la combinaison de deux critères : l'un sur le nombre maximum de sous pas de convergence et l'autre sur l'incrément maximum de déformation entre deux pas de calcul. C'est au pas de calcul qui précéde cette détection que sont relevées les valeurs des contraintes maximales atteintes :math:`\sigma_{xx}` et :math:`\sigma_{yy}`.

L’objectif est de caractériser la courbe de biaxialité qui représente la surface de charge du modèle dans le plan :math:`(\sigma_{xx};\sigma_{yy})`.

Les modes de calcul testés sont :

- 3D volumique ;
- 2D contraintes planes.

L'analyse des résultats porte sur les courbes :

- de biaxialité :math:`(\sigma_{xx};\sigma_{yy})` ;
- de biaxialité normalisée :math:`(\frac{\sigma_{xx}}{|f_{c}|};\frac{\sigma_{yy}}{|f_{c}|})`.

Dans la courbe de biaxialité normalisée, :math:`f_{c}=-25,64~MPa` est la contrainte limite en compression déterminée dans un calcul de référence en contrainte imposée de compression monotone uniaxiale. la courbe calculée de biaxialité normalisée est jugée satisfaite si elle coupe les axes du repère aux deux points :math:`(-1~;~0)` et :math:`(0~;~-1)`.

Solution de référence
+++++++++++++++++++++

Contrairement aux cas de chargements en déplacement imposé traîtés précédemment, dans les cas de chargement en contrainte imposée comme celui-ci, l'évolution temporelle de l'endommagement n'est pas prévisible et celle du déplacement qui en dépend ne l'est pas non plus. Or, du fait des dimensions géométriques unitaires du cas-test, la déformation est équivalente au déplacement et donc l'évolution temporelle de la déformation n'est pas définie *a priori*. En conséquence, les évolutions temporelles de l'endommagement qui dépend de celle de la déformation ainsi que l'évolution temporelle de la contrainte qui dépend de celle de l'endommagement ne sont pas définies *a priori*, ce qui ne permet pas de donner une solution analytique au problème.

Néanmoins, il est possible de donner une solution numérique de référence issue de résultats de calculs dans lesquels on a confiance.
Cette solution de référence est obtenue dans les conditions de calcul suivantes qui sont comparées à celle du cas-test ``mazars_biaxial.dgibi`` dénommé "calcul standard" :

- Un pas de calcul deux fois plus fin que le calcul standard (:math:`1.10^{-3}` au lieu de :math:`2.10^{-3}`) ;
- La réalisation de 180 calculs sur le domaine :math:`\theta \in [45°;225°]`, avec un incrément d'angle :math:`\Delta\theta=1°` au lieu de 72 calculs avec :math:`\Delta\theta=2,5°` pour le calcul standard.

Ecart entre résultat de calcul et solution de référence
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
L'écart entre la contrainte calculée et la solution de référence est évalué indépendamment pour chacune des deux composantes de contrainte, via l'aire sous les courbes :math:`|Ec.rel.\sigma_{xx}|=f(\theta)` et :math:`|Ec.rel.\sigma_{yy}|=f(\theta)`. L'abscisse des courbes est strictement croissante et leur ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante :

- Pour la composante :math:`\sigma_{xx}` :

.. math::
   |Ec.rel.\sigma_{xx}| = \left|\frac{\sigma_{xx_{calc.}} - \sigma_{xx_{ref.}}} {\sigma_{xx_{ref.}}}\right|

- Pour la composante :math:`\sigma_{yy}` :

.. math::
   |Ec.rel.\sigma_{yy}| = \left|\frac{\sigma_{yy_{calc.}} - \sigma_{yy_{ref.}}} {\sigma_{yy_{ref.}}}\right|

Pour chacune des composantes, dans chaque configuration géométrique traîtée, on fournit une valeur scalaire quantitative de l'écart qui correspond à la moyenne intégrale de la courbe :math:`|Ec.rel.\sigma_{xx/yy}|=f(\theta)` définie par :

- Pour la composante :math:`\sigma_{xx}` :
 
.. math::
   Moy.int. = \frac{1}{\theta_{2}-\theta_{1}}\sum_{\theta_{1}}^{^{\theta_{2}}}|Ec.rel.\sigma_{xx}|\Delta\theta

- Pour la composante :math:`\sigma_{yy}` :

 .. math::
   Moy.int. = \frac{1}{\theta_{2}-\theta_{1}}\sum_{\theta_{1}}^{^{\theta_{2}}}|Ec.rel.\sigma_{yy}|\Delta\theta
   
où :math:`[\theta_{1};\theta_{2}]` est l'intersection du domaine de définition angulaire de la contrainte calculée et de la solution de référence.

L'aire sous les courbes est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Par ailleurs, la qualité de la solution calculée est jugée sur la capacité de la courbe de biaxialité normalisée à couper les axes du repère aux deux points :math:`(-1~;~0)` et :math:`(0~;~-1)`.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbe de biaxialité :math:`(\sigma_{xx} ; \sigma_{yy})`
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_biax_SxSy_3d.png
   :width: 15cm
   :align: center
   
   Courbe de biaxialité :math:`(\sigma_{xx} ; \sigma_{yy})`

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- Pour la composante :math:`\sigma_{xx}` : :math:`1,10829.10^{-2} < 2.10^{-2}` ;
- Pour la composante :math:`\sigma_{yy}` : :math:`1,10758.10^{-2} < 2.10^{-2}`.

Courbe de biaxialité normalisée :math:`(\frac{\sigma_{xx}}{|f_{c}|} ; \frac{\sigma_{yy}}{|f_{c}|})`
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_biax_SxSysFc_3d.png
   :width: 15cm
   :align: center
   
   Courbe de biaxialité normalisée :math:`(\frac{\sigma_{xx}}{|f_{c}|} ; \frac{\sigma_{yy}}{|f_{c}|})`

La courbe calculée de biaxialité normalisée coupe les axes du repère aux deux points :math:`(-1~;~0)` et :math:`(0~;~-1)`.
   
En conséquence de ces deux constats, les résultats du cas-test ``mazars_biaxial.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Courbe de biaxialité :math:`(\sigma_{xx} ; \sigma_{yy})`
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_biax_SxSy_2dplan.png
   :width: 15cm
   :align: center
   
   Courbe de biaxialité :math:`(\sigma_{xx} ; \sigma_{yy})`

La moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la solution calculée et la solution de référence est :

- Pour la composante :math:`\sigma_{xx}` : :math:`1,09173.10^{-2} < 2.10^{-2}` ;
- Pour la composante :math:`\sigma_{yy}` : :math:`1,10653.10^{-2} < 2.10^{-2}`.

Courbe de biaxialité normalisée :math:`(\frac{\sigma_{xx}}{|f_{c}|} ; \frac{\sigma_{yy}}{|f_{c}|})`
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_biax_SxSysFc_2dplan.png
   :width: 15cm
   :align: center
   
   Courbe de biaxialité normalisée :math:`(\frac{\sigma_{xx}}{|f_{c}|} ; \frac{\sigma_{yy}}{|f_{c}|})`

La courbe calculée de biaxialité normalisée coupe les axes du repère aux deux points :math:`(-1~;~0)` et :math:`(0~;~-1)`.
   
En conséquence de ces deux constats, les résultats du cas-test ``mazars_biaxial.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.



Triaxial
~~~~~~~~
Le cas-test se dénomme ``mazars_triaxial.dgibi``

On n'applique le cas de chargement triaxial que pour la modélisation :ref:`massif <sec:modeles_beton_test_mass_triax>`. En effet, la triaxialité du chargement n'a pas de sens avec la modélisation poutre à fibres qui ne traite que des chargements de type traction-compression dans la direction de la poutre et de cisaillement dans le plan de sa section.

Le chargement triaxial est la combinaison de deux phases successives : La mise en place au préalable d'un état de confinement auquel on ajoute ensuite un chargement de compression simple en déplacement imposé négatif. On réalise le test dans quatre états de confinement différents qui correspondent aux quatre valeurs de pression hydrostatique, c'est-à-dire de contrainte normale de compression, suivantes : P = 0 Pa/ 1,5 MPa/ 4,5 MPa/ 9 MPa. On applique ensuite le chargement de compression en déplacement imposé négatif, croissant en valeur absolue, jusqu'à atteindre le déplacement maximal : :math:`u_{max}=-4,5.10^{-3}` m.

L'objectif est d'évaluer l'influence du confinement sur la limite en compression et le comportement post-pic du modèle.

L'analyse des résultats porte sur les courbes :

- d'endommagement moyen en fonction du temps ;
- de la contrainte moyenne en fonction de la déformation moyenne ;
- de la force de réaction globale en fonction du déplacement imposé.

Solution de référence
+++++++++++++++++++++

On dispose, pour les quatre valeurs de pression hydrostatique, de résultats expérimentaux en termes de contrainte moyenne et déformation moyenne auxquels les courbes calculées d'évolution de la contrainte en fonction de la déformation peuvent être comparées. 

Ecart entre résultat de calcul et solution de référence
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
L'écart entre la contrainte calculée et la solution de référence est évalué via l'aire sous la courbe :math:`|Ec.rel.\sigma_{zz}|=f(|\epsilon_{zz}|)`.
L'abscisse :math:`|\epsilon_{zz}|` est stictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

.. math::
   |Ec.rel.\sigma_{zz}| = \left|\frac{\sigma_{zz_{calc.}} - \sigma_{zz_{ref.}}} {\sigma_{zz_{ref.}}}\right|

Pour chaque configuration traîtée, on fournit une valeur scalaire quantitative de l'écart qui correspond à la moyenne intégrale de la courbe :math:`|Ec.rel.\sigma_{zz}|=f(|\epsilon_{zz}|)` définie par :
 
.. math::
   Moy.int. = \frac{1}{|\epsilon_{zz_{2}}-\epsilon_{zz_{1}}|}\sum_{|\epsilon_{zz_{1}}|}^{^{|\epsilon_{zz_{2}}|}}|Ec.rel.\sigma_{zz}||\Delta\epsilon_{zz}|
   
où :math:`[\epsilon_{zz_{1}};\epsilon_{zz_{2}}]` est l'intersection du domaine de définition en déformation de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbes d'évolution de l'endommagement
""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbes d'évolution de la contrainte en fonction de la déformation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

Pour les quatre valeurs de pression hydrostatique, la moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la courbe calculée et la courbe expérimentale de référence est :

- Pour P = 0,0 MPa : :math:`1,08653.10^{-1}` ;
- Pour P = 1,5 MPa : :math:`8,44621.10^{-2}` ;
- Pour P = 4,5 MPa : :math:`9,07996.10^{-2}` ;
- Pour P = 9,0 MPa : :math:`1,78290.10^{-1}`.

Les écarts sont quantitativement significatifs. Cependant, la tendance des courbes expérimentales est qualitativement reproduite par le calcul.
En conséquence, les résultats du cas-test ``mazars_triaxial.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Courbes d'évolution de la force de réaction en fonction du déplacement imposé
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_f_3d.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.

Résultats du cas 2D axisymétrique
+++++++++++++++++++++++++++++++++

Courbes d'évolution de l'endommagement
""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_d_2daxi.png
   :width: 15cm
   :align: center
   
   Endommagement moyen en fonction du temps.

Courbes d'évolution de la contrainte en fonction de la déformation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_s_2daxi.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

Pour les quatre valeurs de pression hydrostatique, la moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la courbe calculée et la courbe expérimentale de référence est :

- Pour P = 0,0 MPa : :math:`1,08653.10^{-1}` ;
- Pour P = 1,5 MPa : :math:`8,44693.10^{-2}` ;
- Pour P = 4,5 MPa : :math:`9,08254.10^{-2}` ;
- Pour P = 9,0 MPa : :math:`1,78272.10^{-1}`.

Les écarts sont quantitativement significatifs. Cependant, la tendance des courbes expérimentales est qualitativement reproduite par le calcul.
En conséquence, les résultats du cas-test ``mazars_triaxial.dgibi`` en mode 2D axisymétrique sont jugés satisfaisants.

Courbes d'évolution de la force de réaction en fonction du déplacement imposé
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_triax_f_2daxi.png
   :width: 15cm
   :align: center
   
   Force de réaction en fonction du déplacement imposé.



Test de Willam
~~~~~~~~~~~~~~
Le cas-test se dénomme ``mazars_willam.dgibi``

On n'applique le cas test de Willam que pour la modélisation :ref:`massif <sec:modeles_beton_test_mass_willam>`. En effet, la biaxialité du chargement n'a pas de sens avec la modélisation poutre à fibres qui ne traite que des chargements de type traction-compression dans la direction de la poutre et de cisaillement dans le plan de sa section.

Le chargement du test de Willam est consistué de deux phases successives. La phase 1 consiste en un chargement de traction simple en déformation imposée ``EPXX`` dans la direction X, jusqu'à atteindre le seuil d'endommagement en déformation. La phase 2, dans laquelle on vise l'endommagement complet proche de 1, est la combinaison de trois chargements superposés : tout d'abord le chargement de traction en déformation imposée ``EPXX`` de la phase 1 est poursuivi avec une amplitude de la moitié de ce dernier ; puis un deuxième chargement de traction en déformation imposée ``EPYY`` est appliqué dans la direction Y jusqu'à atteindre les trois quarts de la déformation maximale de la phase 1 ; enfin un troisième chargement de cisaillement en glissement imposé ``GAXY`` est appliqué dans le plan XY jusqu'à atteindre la moitié de la déformation maximale de la phase 1.

L'objectif est d'évaluer l'influence de la rotation du repère de chargement (repère des contraintes principales) sur la réponse post-pic du modèle.

L'analyse des résultats porte sur les courbes :

- d'endomagemment en chaque point de Gauss des modèles massifs en fonction du temps ;
- des différentes composantes de contrainte moyenne en fonction de la déformation moyenne.

Solution de référence
+++++++++++++++++++++

On a choisi des résultats numériques de référence : ceux obtenus par l'équipe LGCNSN (R&DO - Ecole Centrale de Nantes) participant au benchmark du projet MECA [2] avec un modèle d'endommagement isotrope du même type que le modèle Mazars de Cast3M. Il s'agit de courbes contrainte-déformation pour les trois composantes de contrainte activées, nommées **4a. LGCNSN Iso** dans [2] et notées **Ref_SMXX**, **Ref_SMYY** et **Ref_SMXY** dans les figures suivantes, auxquelles les courbes calculées d'évolution de ces trois composantes de contrainte en fonction de la déformation peuvent être comparées. 

Ecart entre résultat de calcul et solution de référence
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
Pour chacune des trois composantes de contrainte :math:`\sigma_{ij}=\sigma_{xx},\sigma_{yy},\sigma_{xy}`, l'écart entre la contrainte calculée et la solution de référence est évalué via l'aire sous la courbe :math:`|Ec.rel.\sigma_{ij}|=f(\epsilon_{xx})`.
L'abscisse :math:`\epsilon_{xx}` est strictement croissante et l'ordonnée est la valeur absolue de l'écart relatif en contrainte définie de la façon suivante : 

.. math::
   |Ec.rel.\sigma_{ij}| = \left|\frac{\sigma_{ij_{calc.}} - \sigma_{ij_{ref.}}} {\sigma_{ij_{ref.}}}\right|

Pour chaque configuration traîtée, on fournit une valeur scalaire quantitative de l'écart qui correspond à la moyenne intégrale de la courbe :math:`|Ec.rel.\sigma_{ij}|=f(\epsilon_{xx})` définie par :
 
.. math::
   Moy.int. = \frac{1}{\epsilon_{xx_{2}}-\epsilon_{xx_{1}}}\sum_{\epsilon_{xx_{1}}}^{^{\epsilon_{xx_{2}}}}|Ec.rel.\sigma_{ij}|\Delta\epsilon_{xx}
   
où :math:`[\epsilon_{xx_{1}};\epsilon_{xx_{2}}]` est l'intersection du domaine de définition en déformation de la contrainte calculée et de la solution de référence.

L'aire sous la courbe est calculée avec l'opérateur ``'INTG'`` de Cast3M.

Résultats du cas 3D volumique
+++++++++++++++++++++++++++++

Courbes d'évolution de l'endommagement
""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_will_d_3d.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbes d'évolution de la contrainte en fonction de la déformation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_will_s_3d.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

Pour les trois composantes de contrainte, la moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la courbe calculée et la courbe numérique de référence est :

- Pour :math:`\sigma_{xx}` : :math:`2,57516.10^{-1}` ;
- Pour :math:`\sigma_{yy}` : :math:`3,95094.10^{-1}` ;
- Pour :math:`\sigma_{xy}` : :math:`1,47488` ;

Les écarts sont quantitativement significatifs. Cependant, la tendance des courbes numériques de référence est qualitativement reproduite par le calcul.
En conséquence, les résultats du cas-test ``mazars_willam.dgibi`` en mode 3D volumique sont jugés satisfaisants.

Résultats du cas 2D contraintes planes
++++++++++++++++++++++++++++++++++++++

Courbes d'évolution de l'endommagement
""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_will_d_2dplan.png
   :width: 15cm
   :align: center
   
   Endommagement aux points de Gauss en fonction du temps.

Courbes d'évolution de la contrainte en fonction de la déformation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. figure:: figures/mazars_will_s_2dplan.png
   :width: 15cm
   :align: center
   
   Contrainte moyenne en fonction de la déformation moyenne.

Pour les trois composantes de contrainte, la moyenne intégrale de la valeur absolue de l'écart relatif en contrainte entre la courbe calculée et la courbe numérique de référence est :

- Pour :math:`\sigma_{xx}` : :math:`2,76686.10^{-1}` ;
- Pour :math:`\sigma_{yy}` : :math:`3,94409.10^{-1}` ;
- Pour :math:`\sigma_{xy}` : :math:`1,47488` ;

Les écarts sont quantitativement significatifs. Cependant, la tendance des courbes numériques de référence est qualitativement reproduite par le calcul.
En conséquence, les résultats du cas-test ``mazars_willam.dgibi`` en mode 2D contraintes planes sont jugés satisfaisants.

