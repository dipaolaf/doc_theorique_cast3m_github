.. _sec:modeles_beton_tests:

Spécification des cas tests
===========================

Ce chapitre présente l'ensemble des cas de chargement appliqués pour effectuer les tests des lois de comportement pour
le béton disponibles dans Cast3M. Il se limite à la seule description des chargements et des phénomènes étudiés.

D'autres chapitres sont dédiés à la :ref:`vérification <sec:modeles_beton_verif>` et à la :ref:`validation <sec:modeles_beton_valid>`.
Ils détaillent les résultats de ces tests sur l'ensemble des lois de comportement.


Cas tests pour les modèles poutre à fibres
------------------------------------------

.. _sec:modeles_beton_test_pout_trac_mono:

Traction monotone
~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_trac_mono_char_3dpaf.png
   :width: 15cm
   :align: center

   Traction simple sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de traction simple monotone. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise à un chargement de traction dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en l'augmentant progressivement jusqu'à une valeur :math:`u_{max}`. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction monotone : blocages et chargement

   .. literalinclude:: dgibi/mazars_traction.dgibi
      :language: gibiane
      :lines: 339-350
      :linenos:
      :lineno-start: 339

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_traction_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Traction - Maillage initial et déformé (x333) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/ricbet_traction.dgibi>`


.. _sec:modeles_beton_test_pout_comp_mono:

Compression monotone
~~~~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_comp_mono_char_3dpaf.png
   :width: 15cm
   :align: center

   Compression simple sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de compression simple monotone. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise à un chargement de compression dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en l'augmentant (en valeur absolue) progressivement jusqu'à une valeur :math:`u_{max} (<0)`. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Compression monotone : blocages et chargement

   .. literalinclude:: dgibi/mazars_compression.dgibi
      :language: gibiane
      :lines: 355-366
      :linenos:
      :lineno-start: 355

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_compression_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Compression - Maillage initial et déformé (x33) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_compression.dgibi>`


.. _sec:modeles_beton_test_pout_trac_cycl:

Traction cyclique
~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_trac_cycl_char_3dpaf.png
   :width: 15cm
   :align: center

   Traction simple cyclique sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de traction simple cyclique. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise à un chargement de traction dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur du déplacement au pic augmente progressivement jusqu'à une valeur :math:`u_{max}`. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction cyclique : blocages et chargement

   .. literalinclude:: dgibi/mazars_traction_cyclique.dgibi
      :language: gibiane
      :lines: 384-396
      :linenos:
      :lineno-start: 384

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_traction_cyclique_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Traction cyclique - Maillage initial et déformé (x333) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_cyclique.dgibi>`


.. _sec:modeles_beton_test_pout_comp_cycl:

Compression cyclique
~~~~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_comp_cycl_char_3dpaf.png
   :width: 15cm
   :align: center

   Compression simple cyclique sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de compression simple cyclique. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise à un chargement de compression dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur du déplacement au pic augmente (en valeur absolue) progressivement jusqu'à une valeur :math:`u_{max} (<0)`. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Compression cyclique : blocages et chargement

   .. literalinclude:: dgibi/mazars_compression_cyclique.dgibi
      :language: gibiane
      :lines: 401-413
      :linenos:
      :lineno-start: 401

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_compression_cyclique_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Compression cyclique - Maillage initial et déformé (x33) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_compression_cyclique.dgibi>`


.. _sec:modeles_beton_test_pout_trac_comp:

Traction compression
~~~~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_trac_comp_char_3dpaf.png
   :width: 15cm
   :align: center

   Traction compression sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de traction compression alternées. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise successivement à un chargement de traction puis de compression dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en deux phases successives de sens opposés : tout  d'abord en augmentant progressivement le déplacement jusqu'à la valeur :math:`u_{t max} > 0` (traction), puis après changement de sens en l'augmentant (en valeur absolue) progressivement jusqu'à la valeur :math:`u_{c max} < 0` (compression). On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction compression : blocages et chargement

   .. literalinclude:: dgibi/mazars_traction_compression.dgibi
      :language: gibiane
      :lines: 518-530
      :linenos:
      :lineno-start: 518

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_traction_compression_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Traction compression - Maillage initial et déformé (x33) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_compression.dgibi>`


.. _sec:modeles_beton_test_pout_trac_comp_trac:

Traction compression traction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_trac_comp_trac_char_3dpaf.png
   :width: 15cm
   :align: center

   Traction compression traction sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test dont le chargement passe alternativement de traction à compression puis à nouveau traction. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise successivement à un chargement de traction, de compression, puis à nouveau de traction dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en trois phases successives de sens opposés : tout  d'abord en augmentant progressivement le déplacement jusqu'à la valeur :math:`u_{t1 max} > 0` (traction), puis après changement de sens en l'augmentant (en valeur absolue) progressivement jusqu'à la valeur :math:`u_{c2 max} < 0` (compression) et enfin, après un ultime retour au sens initial, en augmentant à nouveau progressivement le déplacement jusqu'à la valeur :math:`u_{t3 max} > 0` (traction). On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction compression traction : blocages et chargement

   .. literalinclude:: dgibi/mazars_traction_compression_traction.dgibi
      :language: gibiane
      :lines: 699-711
      :linenos:
      :lineno-start: 699

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_traction_compression_traction_film_defo_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Traction compression traction - Maillage initial et déformé (x33) du modèle poutre à fibre 3D.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_compression_traction.dgibi>`


.. _sec:modeles_beton_test_pout_cisa_mono:

Cisaillement
~~~~~~~~~~~~

.. figure:: figures/mazars_cisa_mono_beta1.06_char_3dpaf.png
   :width: 15cm
   :align: center

   Cisaillement simple sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de cisaillement simple. On considère une poutre de longueur :math:`L` et section transversale :math:`S` soumise à un chargement de cisaillement dans le plan de sa section d'extrémité.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UY** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en l'augmentant progressivement jusqu'à une valeur de déplacement maximal correspondant à une déformation de cisaillement :math:`\gamma_{xy_{max}}` (glissement) fixée arbitrairement. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément ainsi que les rotations de l'extrémité pilotée en déplacement.

Les instructions Gibiane correspondantes sont :

.. admonition:: Cisaillement : blocages et chargement

   .. literalinclude:: dgibi/mazars_cisaillement.dgibi
      :language: gibiane
      :lines: 312-324
      :linenos:
      :lineno-start: 312

La déformée au cours du chargement est représentée sur la figure suivante.

.. figure:: figures/mazars_cisaillement_film_defo_HPP_3D_PaF_5.gif
   :width: 15cm
   :align: center

   Cisaillement - Maillage initial et déformé (x91) du modèle poutre à fibre 3D.

Remarque
""""""""
A noter que pour décrire finement la déformée au cours du chargement, en particulier le retrait de la section chargée vers la section encastrée (UX<0), il est nécessaire de se placer dans l'hypothèse des grands déplacements (indice de la table de PASAPAS ``'GRANDS_DEPLACEMENT'= VRAI``) qui active par défaut la prise en compte des contraintes dans le calcul de la rigidité ``'K_SIGMA'= VRAI``. Il se trouve que cette prise en compte n'est pas opérationnelle dans les modèles poutre à fibres, ce qui nécessite de renseigner l'indice de la table de PASAPAS ``'K_SIGMA'= FAUX``. 

Néanmoins une étude comparative des résultats du présent cas-test obtenus avec ces hypothèses ainsi que dans l'hypothèse des petites perturbations (HPP, par défaut dans PASAPAS) montre que :

- Le retrait de la section chargée (UX = -1.2E-05 m) est, d'une part, négligeable devant le déplacement qui lui est imposé (UY = 1.20E-02 m) et, d'autre part, comparable au déplacement nul (UX = 0) obtenu en HPP ;
- L'écart maximal observé sur la contrainte de cisaillement calculée au cours du chargement dans les deux cas est négligeable.

En conséquence, on choisit comme pour les autres cas-tests d'appliquer l'hypothèse des petites perturbations (HPP) pour le cas-test de cisaillement.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_cisaillement.dgibi>`







Cas tests pour les modèles massifs
----------------------------------

.. _sec:modeles_beton_test_mass_trac_mono:

Traction monotone
~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de traction simple monotone. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en l'augmentant progressivement jusqu'à une valeur :math:`u_{max}`. On bloque les déplacements de l'autre face en laissant libre la contraction par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction monotone : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_traction.dgibi
      :language: gibiane
      :lines: 121-130
      :linenos:
      :lineno-start: 121

.. admonition:: Traction monotone : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_traction.dgibi
      :language: gibiane
      :lines: 753-761
      :linenos:
      :lineno-start: 753

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_trac_mono_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_trac_mono_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_trac_mono_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_trac_mono_char_2daxi.png
   :width: 0%

   Traction - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_traction_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_traction_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_traction_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_trac_mono_char_2daxi.png
   :width: 0%

   Traction - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/ricbet_traction.dgibi>`


.. _sec:modeles_beton_test_mass_comp_mono:

Compression monotone
~~~~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de compression simple monotone. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en l'augmentant (en valeur absolue) progressivement jusqu'à une valeur :math:`u_{max} (<0)`. On bloque les déplacements de l'autre face en laissant libre l'expansion par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Compression monotone : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_compression.dgibi
      :language: gibiane
      :lines: 121-130
      :linenos:
      :lineno-start: 121

.. admonition:: Compression monotone : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_compression.dgibi
      :language: gibiane
      :lines: 793-801
      :linenos:
      :lineno-start: 793

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_comp_mono_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_comp_mono_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_comp_mono_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_comp_mono_char_2daxi.png
   :width: 0%

   Compression - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_compression_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_compression_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_compression_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_comp_mono_char_2daxi.png
   :width: 0%

   Compression - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_compression.dgibi>`


.. _sec:modeles_beton_test_mass_trac_cycl:

Traction cyclique
~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de traction simple cyclique. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur du déplacement au pic augmente progressivement jusqu'à une valeur :math:`u_{max}`. On bloque les déplacements de l'autre face en laissant libre la contraction par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction cyclique : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_traction_cyclique.dgibi
      :language: gibiane
      :lines: 121-131
      :linenos:
      :lineno-start: 121

.. admonition:: Traction cyclique : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_traction_cyclique.dgibi
      :language: gibiane
      :lines: 889-898
      :linenos:
      :lineno-start: 889

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_trac_cycl_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_trac_cycl_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_trac_cycl_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_trac_cycl_char_2daxi.png
   :width: 0%

   Traction cyclique - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_traction_cyclique_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_traction_cyclique_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_traction_cyclique_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_trac_cycl_char_2daxi.png
   :width: 0%

   Traction cyclique - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_cyclique.dgibi>`


.. _sec:modeles_beton_test_mass_comp_cycl:

Compression cyclique
~~~~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de compression simple cyclique. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces entre 0 et un pic de façon cyclique avec retour à 0 entre chaque cycle. La valeur du déplacement au pic augmentant (en valeur absolue) progressivement jusqu'à une valeur :math:`u_{max} (<0)`. On bloque les déplacements de l'autre face en laissant libre l'expansion par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Compression cyclique : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_compression_cyclique.dgibi
      :language: gibiane
      :lines: 121-131
      :linenos:
      :lineno-start: 121

.. admonition:: Compression cyclique : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_compression_cyclique.dgibi
      :language: gibiane
      :lines: 915-924
      :linenos:
      :lineno-start: 915

Les blocages et le chargement sont représentés sur la figure suivante.
   
.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_comp_cycl_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_comp_cycl_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_comp_cycl_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_comp_cycl_char_2daxi.png
   :width: 0%

   Compression cyclique - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_compression_cyclique_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_compression_cyclique_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_compression_cyclique_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_comp_cycl_char_2daxi.png
   :width: 0%

   Compression cyclique - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_compression_cyclique.dgibi>`


.. _sec:modeles_beton_test_mass_trac_comp:

Traction compression
~~~~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de traction compression alternées. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en deux phases successives de sens opposés : tout  d'abord en augmentant progressivement le déplacement jusqu'à la valeur :math:`u_{t max} > 0` (traction), puis après changement de sens en l'augmentant (en valeur absolue) progressivement jusqu'à la valeur :math:`u_{c max} < 0` (compression). On bloque les déplacements de l'autre face en laissant libre la contraction par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction compression : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_traction_compression.dgibi
      :language: gibiane
      :lines: 125-135
      :linenos:
      :lineno-start: 125

.. admonition:: Traction compression : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_traction_compression.dgibi
      :language: gibiane
      :lines: 1281-1290
      :linenos:
      :lineno-start: 1281

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_trac_comp_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_trac_comp_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_trac_comp_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_trac_comp_char_2daxi.png
   :width: 0%

   Traction compression - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_traction_compression_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_traction_compression_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_traction_compression_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_trac_comp_char_2daxi.png
   :width: 0%

   Traction compression - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_compression.dgibi>`


.. _sec:modeles_beton_test_mass_trac_comp_trac:

Traction compression traction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test dont le chargement passe alternativement de traction à compression puis à nouveau traction. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en trois phases successives de sens opposés : tout  d'abord en augmentant progressivement le déplacement jusqu'à la valeur :math:`u_{t1 max} > 0` (traction), puis après changement de sens en l'augmentant (en valeur absolue) progressivement jusqu'à la valeur :math:`u_{c2 max} < 0` (compression) et enfin, après un ultime retour au sens initial, en augmentant à nouveau progressivement le déplacement jusqu'à la valeur :math:`u_{t3 max} > 0` (traction). On bloque les déplacements de l'autre face en laissant libre la contraction par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacement **UX** de la face opposée "gauche" (dans le plan :math:`x=0`).
  Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de la ligne "haute" (située en :math:`z=L`).
  On bloque alors le déplacement **UZ** de la ligne opposée "basse" (en :math:`z=0`).

Les instructions Gibiane correspondantes sont :

.. admonition:: Traction compression traction : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_traction_compression_traction.dgibi
      :language: gibiane
      :lines: 132-142
      :linenos:
      :lineno-start: 132

.. admonition:: Traction compression traction : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_traction_compression_traction.dgibi
      :language: gibiane
      :lines: 1817-1826
      :linenos:
      :lineno-start: 1817

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_trac_comp_trac_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_trac_comp_trac_char_2dplan.png
          :width: 70%
          :align: center
          
     - .. image:: figures/mazars_trac_comp_trac_char_2daxi.png
          :width: 70%
          :align: center

.. figure:: figures/mazars_trac_comp_trac_char_2daxi.png
   :width: 0%

   Traction compression traction - Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_traction_compression_traction_film_defo_3D_V_5.gif
   :width: 51%
   :align: center
.. image:: figures/mazars_traction_compression_traction_film_defo_2D_CP_5.gif
   :width: 49%
.. image:: figures/mazars_traction_compression_traction_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_trac_comp_trac_char_2daxi.png
   :width: 0%

   Traction compression traction - Maillage initial et déformé (x333) des modèles massifs 3D, 2D plan et 2D axisymétrique.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_traction_compression_traction.dgibi>`


.. _sec:modeles_beton_test_mass_cisa_mono:

Cisaillement
~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de cisaillement simple. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en l'augmentant progressivement jusqu'à une valeur de déplacement maximal correspondant à une déformation de cisaillement :math:`\gamma_{xy_{max}}` (glissement) fixée arbitrairement. On bloque les déplacements de l'autre face en laissant libre la contraction par effet de Poisson tout en s'assurant que les deux faces restent des sections droites.

- En 3D, on pilote le déplacement **UY** de la face "droite" (située dans le plan :math:`x=L`) tout en conservant le déplacement **UX** uniforme sur cette face (la section reste droite) et on bloque les déplacements **UY** et **UX** de la face opposée "gauche" (dans le plan :math:`x=0`). La contraction par effet de Poisson est possible dans la direction **Z**. Le mouvement de corps rigide est empêché en bloquant, dans la face "gauche", les déplacements **UZ** de l'arête du bas de direction **Y** en :math:`(x=0, z=0)` ainsi que les déplacements **UX** et **UY** de l'arête de devant de direction **Z** en :math:`(x=0, y=0)`.
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.

Les instructions Gibiane correspondantes sont :

.. admonition:: Cisaillement : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_cisaillement.dgibi
      :language: gibiane
      :lines: 134-147
      :linenos:
      :lineno-start: 134

Les blocages et le chargement sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_cisa_mono_beta1.06_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_cisa_mono_beta1.06_char_2dplan.png
          :width: 65%
          :align: center

.. figure:: figures/mazars_cisa_mono_beta1.06_char_2dplan.png
   :width: 0%

   Cisaillement - Blocages et chargement de déplacement imposé sur le cube (3D) et le carré (2D plan).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_cisaillement_film_defo_HPP_3D_V_5.gif
   :width: 49%
.. image:: figures/mazars_cisaillement_film_defo_HPP_2D_CP_5.gif
   :width: 50%

.. figure:: figures/mazars_cisa_mono_beta1.06_char_2dplan.png
   :width: 0%

   Cisaillement - Maillage initial et déformé (x91) des modèles volumiques 3D et 2D plan.

Remarque
""""""""
A noter que pour décrire finement la déformée au cours du chargement, en particulier le retrait de la section chargée vers la section encastrée (UX<0), il est nécessaire de se placer dans l'hypothèse des grands déplacements (indice de la table de PASAPAS ``'GRANDS_DEPLACEMENT'= VRAI``) qui active par défaut la prise en compte des contraintes dans le calcul de la rigidité ``'K_SIGMA'= VRAI``. Il se trouve que cette prise en compte n'est pas opérationnelle dans les modèles poutre à fibres, ce qui nécessite de renseigner l'indice de la table de PASAPAS ``'K_SIGMA'= FAUX`` pour se placer dans les même conditions de calcul avec les modèles massifs qu'avec les modèles poutre à fibres. 

Néanmoins une étude comparative des résultats du présent cas-test obtenus avec ces hypothèses ainsi que dans l'hypothèse des petites perturbations (HPP, par défaut dans PASAPAS) montre que :

- Le retrait de la section chargée (UX = -7.2E-05 m) est, d'une part, négligeable devant le déplacement qui lui est imposé (UY = 1.20E-02 m) et, d'autre part, comparable au déplacement nul (UX = 0) obtenu en HPP ;
- L'écart maximal observé sur la contrainte de cisaillement calculée au cours du chargement dans les deux cas est négligeable.

En conséquence, on choisit comme pour les autres cas-tests d'appliquer l'hypothèse des petites perturbations (HPP) pour le cas-test de cisaillement.

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_cisaillement.dgibi>`


.. _sec:modeles_beton_test_mass_biax:

Biaxial
~~~~~~~

Description
"""""""""""

Il s'agit d'un test combinant des chargements monotones de traction ou de compression en contrainte imposée, exercés dans deux directions de l'espace tridimensionnel de manière proportionnelle. Les dimensions dépendent de l'hypothèse de calcul retenue :

- En 3D on considère un cube d'arête :math:`L`.
- En 2D plan on considère un carré de coté :math:`L`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à imposer, sur les faces :math:`x=L` et :math:`y=L`, les contraintes
normales de manière proportionnelle via une relation trigonométrique :

.. math::
   \sigma_{xx}=\sigma_{max} \textrm{cos} \theta

.. math::
   \sigma_{yy}=\sigma_{max} \textrm{sin} \theta
   
Suivant la valeur de :math:`\theta`, la combinaison biaxiale :math:`(\sigma_{xx};\sigma_{yy})` est de type soit (traction ; traction), soit (traction ; compression) ou l'inverse, soit (compression ; compression).

On effectue autant de calculs que l'on souhaite de combinaisons biaxiales en faisant varier la valeur de :math:`\theta` et en imposant :math:`\sigma_{max}` suffisament grand pour atteindre la ruine. 

Les calculs sont arrêtés à la detection de la ruine complète (dommage proche de 1), qui résulte d'une combinaison entre un critère sur le nombre de sous-pas de convergence limité à 1 et un critère sur l'incrément de déformation entre 2 pas de calcul consécutifs limité à :math:`2.10^{-3}`. C'est au pas de calcul précédant cet instant que sont relevées les valeurs de :math:`\sigma_{xx}` et :math:`\sigma_{yy}` qui constituent les coordonnées des points de la courbe de biaxialité.

Les critères de détection de la ruine pour arrêter le calcul sont définis dans la procédure ``PERSO1`` de Cast3M.

L’objectif est de caractériser la courbe de biaxialité qui représente la surface de charge du modèle dans le plan :math:`(\sigma_{xx} ; \sigma_{yy})`.
On peut ainsi évaluer la contrainte maximale en traction / compression / cisaillement du modèle.

Les déplacements des faces opposées :math:`x=0` et :math:`y=0` sont bloqués dans leur direction normale respective en laissant libre la contraction ou l'expansion par effet de Poisson (de manière à être en état de contraintes planes). 
En 3D, le mouvement de corps rigide est empêché en bloquant le déplacement **UZ** du coin (0 0 0).

Les instructions Gibiane correspondantes sont :

.. admonition:: Biaxial : chargement

   .. literalinclude:: dgibi/mazars_biaxial.dgibi
      :language: gibiane
      :lines: 187
      :linenos:
      :lineno-start: 187

   .. literalinclude:: dgibi/mazars_biaxial.dgibi
      :language: gibiane
      :lines: 192-194
      :linenos:
      :lineno-start: 194

   .. literalinclude:: dgibi/mazars_biaxial.dgibi
      :language: gibiane
      :lines: 200-205
      :linenos:
      :lineno-start: 200

.. admonition:: Biaxial : blocages pour le cas 3D

   .. literalinclude:: dgibi/mazars_biaxial.dgibi
      :language: gibiane
      :lines: 183-184
      :linenos:
      :lineno-start: 183

.. admonition:: Biaxial : blocages pour le cas 2D plan

   .. literalinclude:: dgibi/mazars_biaxial.dgibi
      :language: gibiane
      :lines: 527-528
      :linenos:
      :lineno-start: 527

Les blocages et le chargement dans la situation de biaxialité :math:`\theta=120°` (:math:`\sigma_{xx}` : traction ; :math:`\sigma_{yy}` : compression) sont représentés sur la figure suivante.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_biax_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_biax_char_2dplan.png
          :width: 65%
          :align: center

.. figure:: figures/mazars_biax_char_2dplan.png
   :width: 0%

   Biaxial (:math:`\theta=120°`) - Blocages et chargement biaxial de contraintes imposées sur le cube (3D) et le carré (2D plan).

La déformée au cours du chargement est représentée sur la figure suivante.

.. image:: figures/mazars_biaxial_film_defo_3D_V_5.gif
   :width: 50%
.. image:: figures/mazars_biaxial_film_defo_2D_CP_5.gif
   :width: 49%

.. figure:: figures/mazars_biax_char_2dplan.png
   :width: 0%

   Biaxial (:math:`\theta=120°`) - Maillage initial et déformé (x516) des modèles volumiques 3D et 2D plan.

A noter que le chargement en contraintes imposées est appliqué via l'opérateur ``'PRES'`` de Cast3M. Dans cette commande, une valeur négative de la pression correspond à un chargement de traction tandis qu'une valeur positive correspond à un chargement de compression. 

Ainsi, dans le cas des illustrations où :math:`\theta=120°` et sachant que :math:`\sigma_{max}>0`, on a :

.. math::
   \textrm{cos}\theta=-\frac{1}{2}\textrm{, d'où }\sigma_{xx}=-\frac{1}{2}\sigma_{max}<0\textrm{ : traction}

.. math::
   \textrm{sin}\theta=\frac{\sqrt{3}}{2}\textrm{, d'où }\sigma_{yy}=\frac{\sqrt{3}}{2}\sigma_{max}>0\textrm{ : compression}


Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_biaxial.dgibi>`


.. _sec:modeles_beton_test_mass_triax:

Triaxial
~~~~~~~~

Description
"""""""""""

Il s'agit d'un test combinant un chargement de pression hydrostatique et un chargement de compression axiale simple monotone. 
Quatre calculs successifs sont effectués pour autant de valeurs croissantes de la pression hydrostatique. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un parallélépipède rectangle de base carrée de côté :math:`L=\sqrt{\pi}R` et de hauteur :math:`H` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à imposer au préalable une contrainte normale de compression sur l'enveloppe de l'échantillon, puis à piloter le déplacement de sa face supérieure en l'augmentant (en valeur absolue) progressivement jusqu'à une valeur :math:`u_{max}(<0)`. La particularité de l'essai est que l'expansion par effet de Poisson est entravée par la pression hydrostatique.

- En 3D, la contrainte normale de compression est appliquée sur les faces "droite" (située dans le plan :math:`x=L`), "arrière" (dans le plan :math:`y=L`) et "supérieure" (dans le plan :math:`z=H`) et on bloque les déplacements des faces opposées dans les directions normales aux faces. Puis on pilote le déplacement **UZ** de la face supérieure (dans le plan :math:`z=H`), le déplacement **UZ** de la face opposée inférieure (dans le plan :math:`z=0`) étant déjà bloqué.
- En 2D axisymétrique, la contrainte normale de compression est appliquée sur la surface latérale cylindrique (située en :math:`r=R`) et sur la surface plane supérieure (dans le plan :math:`z=H`), puis on pilote le déplacement **UZ** de cette même face. On bloque le déplacement **UZ** de la face opposée inférieure (dans le plan :math:`z=0`).

Les quatres valeurs de contrainte normale de compression (pression hydrostatique) pour lesquelles on effectue des calculs sont les suivantes : P = 0 Pa/ 1,5 MPa/ 4,5 MPa/ 9 MPa.

Les instructions Gibiane correspondantes sont :

.. admonition:: Triaxial : chargements de pression hydrostatique pour les cas 3D et 2D axisymétrique

   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 65-67
      :linenos:
      :lineno-start: 65

.. admonition:: Triaxial : blocages et chargements pour le cas 3D

   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 133-139
      :linenos:
      :lineno-start: 133
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 144-147
      :linenos:
      :lineno-start: 144
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 150-154
      :linenos:
      :lineno-start: 150
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 155
      :linenos:
      :lineno-start: 155
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 159-160
      :linenos:
      :lineno-start: 159
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 166-170
      :linenos:
      :lineno-start: 166
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 185-186
      :linenos:
      :lineno-start: 185

.. admonition:: Triaxial : blocages et chargements pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 368-374
      :linenos:
      :lineno-start: 368
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 379-382
      :linenos:
      :lineno-start: 379
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 385-388
      :linenos:
      :lineno-start: 385
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 389
      :linenos:
      :lineno-start: 389
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 393-394
      :linenos:
      :lineno-start: 393
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 400-404
      :linenos:
      :lineno-start: 400
   .. literalinclude:: dgibi/mazars_triaxial.dgibi
      :language: gibiane
      :lines: 419-420
      :linenos:
      :lineno-start: 419

Les blocages et les chargements, pour la pression hydrostatique nulle (0 MPa) et maximale (9 MPa), sont représentés sur les figures suivantes.

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_triax_0MPa_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_triax_0MPa_char_2daxi.png
          :width: 50%
          :align: center

.. figure:: figures/mazars_triax_0MPa_char_2daxi.png
   :width: 0%

   Triaxial - Blocages et chargement triaxial de pression hydrostatique nulle (0 MPa) et de déplacement axial (en rouge) imposés sur le parallélépipède (3D) et le cylindre (2D axisymétrique).

.. list-table::
   :width: 100%
   :class: borderless
   
   * - .. image:: figures/mazars_triax_9MPa_char_3d.png
          :width: 100%
          :align: center
          
     - .. image:: figures/mazars_triax_9MPa_char_2daxi.png
          :width: 50%
          :align: center

.. figure:: figures/mazars_triax_9MPa_char_2daxi.png
   :width: 0%

   Triaxial - Blocages et chargement triaxial de pression hydrostatique (9 MPa, en vert) et de déplacement axial (en rouge) imposés sur le parallélépipède (3D) et le cylindre (2D axisymétrique).

La déformée au cours du chargement, pour la pression hydrostatique nulle (0 MPa) et maximale (9 MPa), est représentée sur les figures suivantes.

.. image:: figures/mazars_triaxial_0MPa_film_defo_3D_V_5.gif
   :width: 50%
.. image:: figures/mazars_triaxial_0MPa_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_triax_9MPa_char_2daxi.png
   :width: 0%

   Triaxial - Maillage initial et déformé (x10) des modèles volumiques 3D et 2D plan - Pression hydrostatique nulle (0 MPa).

.. image:: figures/mazars_triaxial_9MPa_film_defo_3D_V_5.gif
   :width: 50%
.. image:: figures/mazars_triaxial_9MPa_film_defo_2D_axi_5.gif
   :width: 49%

.. figure:: figures/mazars_triax_9MPa_char_2daxi.png
   :width: 0%

   Triaxial - Maillage initial et déformé (x10) des modèles volumiques 3D et 2D plan - Pression hydrostatique maximale (9 MPa).

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_triaxial.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/ricbet_triaxial.dgibi>`


.. _sec:modeles_beton_test_mass_willam:

Test de Willam
~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test comprenant une première phase de chargement en traction simple, suivie d'une seconde phase combinant de la bi-traction dans la direction de la traction initiale et dans sa direction orthogonale et du cisaillement dans le plan orthogonal à la direction de traction initiale. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube d'arête :math:`L` ;
- en 2D plan, on considère un domaine carré de côté :math:`L` et d'épaisseur :math:`e` ;

L'objectif du test est d'observer la réponse du modèle de comportement lorsque le repère du chargement, c'est-à-dire le repère des contraintes principales, tourne. Il n'existe pas de résultat expérimental de référence pour ce test, étant données les conditions aux limites et de chargement difficiles à mettre en oeuvre expérimentalement. En revanche, il existe un certain nombre de résultats numériques dans la littérature auxquels les résultats de calcul peuvent être comparés.

Paramètres issus de la bibliographie
""""""""""""""""""""""""""""""""""""

L'article d'origine décrivant le test de Willam est le suivant :

 [1] Willam, K.; Pramono, E.; Sture, S. Fundamental issues of smeared crack models. In Proc. of the SEM-RILEM Int. conf. on fracture of concrete and rock, TX USA 17-19 June 1987, Shah S.P., Swartz S.E. (eds), 1989, pp. 142-157.

La géométrie du problème, les paramètres élastiques du matériau et certains paramètres du modèle de comportement, ainsi que les réultats numériques de références (courbes **4a. LGCNSN Iso**) otenues avec un modèle d'endommagement isotrope comparable au modèle Mazars implémenté dans Cast3M, sont issus de l'article suivant :

 [2] Ghavamian, S.; Carol, I.; Delaplace A. Discussions over MECA project results. Revue Française de Génie Civil. 7 (2003) pp. 543-581. doi:10.1080/127951119.2003.9692509.

Les paramètres de la seconde phase de chargement sont issus de l'article suivant :

 [3] Wosatko, A.; Szczecina, M.; Winnicki A. Selected Concrete Models Studied Using Willam's Test. Materials 2020, 13, 4756; doi:10.3390/ma13214756.

Enfin, le paramètre **BTRA** du modèle Mazars est issu d'une communication personnelle de L. Jason (CEA/DES/ISAS/DM2S/SEMT), d'après sa contribution au benchmark [2]. Le paramètre **ATRA**, qui pilote la valeur asymptotique vers laquelle tendent les contraintes lorsque l'endommagement est maximal, est choisi pour optimiser la corrélation du calcul avec les résultats numériques de référence.


.. admonition:: Test de Willam : Paramètres géométrique, matériau et chargement

   .. literalinclude:: dgibi/mazars_willam.ecr
      :lines: 119-140
      :linenos:
      :lineno-start: 119

Blocages et chargement
""""""""""""""""""""""

Le test se décompose en deux phases successives. Dans la phase 1, le chargement consiste à piloter la déformation du maillage dans l'une de ses directions principales en l'augmentant progressivement jusqu'à atteindre la déformation seuil d'endommagement, l'une des deux faces dont la normale est colinéaire à cette direction étant bloquée en déplacement et libre de se contracter par effet de Poisson. Plusieurs chargements se superposent dans la phase 2 : tout d'abord, le chargement de la phase 1 est poursuivi avec une amplitude de la moitié de ce dernier ; ensuite, un deuxième chargement de traction orthogonale consiste à piloter la déformation du maillage dans une direction perpendiculaire à la première en l'augmentant progressivement jusqu'à atteindre les trois quarts de la déformation maximale de la phase 1 ; enfin, un troisième chargement de cisaillement consiste à piloter le glissement du maillage dans le plan défini par les directions orthogonales des deux premiers chargements de la phase 2 en l'augmentant progressivement jusqu'à atteindre la moitié de la déformation maximale de la phase 1.

En pratique dans Cast3M, on applique sur tout le maillage les deux phases du chargement de déformation imposée souhaité dans un premier calcul élastique, en tenant compte des conditions aux limites adéquates aux frontières du maillage (une face encastrée et libre en striction). Puis on récupère les champs de déplacements ainsi calculés pour les appliquer comme chargement en déplacement imposé sur tout le maillage d'un second calcul prenant en compte le comportement non linéaire endomageable du matériau. A noter que ce second calcul ne requiert pas de conditions aux limites cinématiques, l'ensemble du maillage étant piloté en déplacement imposé.

- En 3D, pour le premier calcul élastique, on pilote les déformations **EPXX**, **EPYY**, **EPZZ** et **GAXY** dans tout le maillage et on bloque le déplacement **UX** de la face "gauche" (dans le plan :math:`x=0`). Le mouvement de corps rigide est empêché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0) ; pour le second calcul non linéaire, on utilise les champs de déplacements résultant du premier calcul pour piloter les déplacements de tout le maillage.
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.

Les instructions Gibiane correspondantes sont :

.. admonition:: Test de Willam : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/mazars_willam.dgibi
      :language: gibiane
      :lines: 149-195
      :linenos:
      :lineno-start: 149

   .. literalinclude:: dgibi/mazars_willam.dgibi
      :language: gibiane
      :lines: 197-230
      :linenos:
      :lineno-start: 197

La représentation des blocages et des chargements n'étant pas suffisament explicite, on représente sur la figure suivante l'évolution de la déformée qui en résulte au cours du chargement. 

.. image:: figures/mazars_willam_film_defo_3D_V_5.gif
   :width: 53%
.. image:: figures/mazars_willam_film_defo_2D_CP_5.gif
   :width: 46%

.. figure:: figures/mazars_will_char_2dplan.png
   :width: 0%

   Test de Willam - Maillage initial et déformé (x500) résultant des blocages et du chargement imposés sur le parallélépipède (3D) et le carré (2D plan).

L'évolution au cours du chargement de la rotation du repère du chargement, c'est-à-dire du repère des contraintes principales, est représenté sur la figure suivante.

.. image:: figures/mazars_willam_film_prin_3D_V_5.gif
   :width: 55%
.. image:: figures/mazars_willam_film_prin_2D_CP_5.gif
   :width: 44%

.. figure:: figures/mazars_will_prin_2dplan.png
   :width: 0%

   Test de Willam - Rotation du repère des contraintes principales sur le parallélépipède (3D) et le carré (2D plan).

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/mazars_willam.dgibi>`

