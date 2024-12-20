.. _sec:modeles_beton_tests:

Spécification des cas tests
===========================

Ce chapitre présente l'ensembe des cas de chargement appliqués pour effectuer les tests des lois de comportement pour
le béton disponibles dans Cast3M. Il se limite à la seule description des chargements et des phénomènes étudiés.

D'autres chapitres sont dédiés à la :ref:`vérification <sec:modeles_beton_verif>` et à la :ref:`validation <sec:modeles_beton_valid>`.
Ils détaillent les résultats de ces tests sur l'ensemble des lois de comportement.


Cas tests pour les modèles poutre à fibre
-----------------------------------------

.. _sec:modeles_beton_test_pout_trac_mono:

Traction monotone
~~~~~~~~~~~~~~~~~

.. figure:: figures/mazars_trac_mono_char_3dpaf.png
   :width: 15cm
   :align: center

   Traction simple sur un modèle d'éléments finis poutre.

Description
"""""""""""

Il s'agit d'un test de traction simple monotone. On considère une poutre de longueur :math:`L` et section transversale :math:`S`
soumise à un chargement de traction dans la direction de son axe.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement **UX** de l'extrémité (:math:`L` 0 0) de l'élément **TIMO** en l'augmentant
progressivement jusqu'à une valeur :math:`u_{max}`. On bloque les déplacements et les rotations de l'autre extrémité (0 0 0) de l'élément.

Les instructions Gibiane correpondantes sont :

.. admonition:: Traction monotone : blocages et chargement

   .. literalinclude:: dgibi/01_traction.dgibi
      :language: gibiane
      :lines: 188-196
      :linenos:
      :lineno-start: 188

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/01_traction.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/01_traction.dgibi>`


Compression monotone
~~~~~~~~~~~~~~~~~~~~

Traction cyclique
~~~~~~~~~~~~~~~~~

Compression cyclique
~~~~~~~~~~~~~~~~~~~~

Traction compression
~~~~~~~~~~~~~~~~~~~~

Traction compression traction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Cas tests pour les modèles massifs
----------------------------------

.. _sec:modeles_beton_test_mass_trac_mono:

Traction monotone
~~~~~~~~~~~~~~~~~

Description
"""""""""""

Il s'agit d'un test de traction simple monotone. Les dimensions dépendent de l'hypothèse de calcul retenue :

- en 3D, on considère un cube de coté :math:`L` ;
- en 2D plan, on considère un domaine carré de coté :math:`L` et d'épaisseur :math:`e` ;
- en 2D axisymétrique, on considère un cylindre de rayon :math:`R` et de hauteur :math:`H`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à piloter le déplacement d'une des faces en l'augmentant progressivement jusqu'à une valeur :math:`u_{max}`.
On bloque les déplacements l'autre face en laissant libre la contraction par effet de Poisson.

- En 3D, on pilote le déplacement **UX** de la face "droite" (située dans le plan :math:`x=L`) et
  on bloque le déplacements **UX** de la face opposée "gauche" (dans le plan x=0).
  Le mouvement de corps rigide est empeché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0) et **UZ** du coin (0 :math:`L` 0).
- En 2D plan, les conditions sont similaires mais limitées aux degrés de liberté **UX** et **UY**.
- En 2D axisymétrique on pilote le déplacement **UZ** de ligne "haute" (située en :math:`z=L`).
  On bloque alors les déplacements **UZ** de la ligne opposée "basse" (en z=0).

Les instructions Gibiane correpondantes sont :

.. admonition:: Traction monotone : blocages et chargement pour le cas 3D

   .. literalinclude:: dgibi/01_traction.dgibi
      :language: gibiane
      :lines: 57-66
      :linenos:
      :lineno-start: 57

.. admonition:: Traction monotone : blocages et chargement pour le cas 2D axisymétrique

   .. literalinclude:: dgibi/01_traction.dgibi
      :language: gibiane
      :lines: 446-454
      :linenos:
      :lineno-start: 446

Les blocages et le chargement sont représentés sur les figures suivantes.

.. image:: figures/mazars_trac_mono_char_3d.png
   :width: 30%
.. image:: figures/mazars_trac_mono_char_2dplan.png
   :width: 30%
.. image:: figures/mazars_trac_mono_char_2daxi.png
   :width: 30%

Blocages et chargement de déplacement imposé sur le cube (3D), le carré (2D plan) et le cylindre (2D axisymétrique).

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/01_traction.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/01_traction.dgibi>`



Compression monotone
~~~~~~~~~~~~~~~~~~~~

Traction cyclique
~~~~~~~~~~~~~~~~~

Compression cyclique
~~~~~~~~~~~~~~~~~~~~

Traction compression
~~~~~~~~~~~~~~~~~~~~

Traction compression traction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cisaillement
~~~~~~~~~~~~

Biaxial
~~~~~~~

Description
"""""""""""

Il s'agit d'un test de traction biaxial en contrainte imposées de manière proportionnelles.

- En 3D on considère un cube de longueur :math:`L`.
- En 2D plan on considère un carré de coté :math:`L`.

Blocages et chargement
""""""""""""""""""""""
Le chargement consiste à imposer, sur les faces :math:`x=L` et :math:`y=L`, les contraintes
normales de manière proportionnelle :

.. math::
   \sigma_{xx}=\sigma_{max} \textrm{cos} \theta

.. math::
   \sigma_{yy}=\sigma_{max} \textrm{sin} \theta

On effectue un calcul pour plusieurs valeurs de :math:`\theta` en imposant :math:`\sigma_{max}` suffisament
grand pour initier l'endommagement. Le calcul est arrêté dès que l’endommagement commence.

L’objectif est de caractériser la surface de charge du modèle dans le plan :math:`\sigma_{zz}=0`.
On peut ainsi évaluer la contrainte maximale en traction/compression/cisaillement du modèle.

Les déplacements des faces opposées :math:`x=0` et :math:`y=0` sont bloqués en laissant libre la
contraction par effet de Poisson (de manière à être en état de contraintes planes). 
Le mouvement de corps rigide est empeché en bloquant les déplacements **UY** et **UZ** du coin (0 0 0)
et **UZ** du coin (0 :math:`L` 0).

Les instructions Gibiane correpondantes sont :

.. admonition:: Traction biaxiale : chargement

   .. literalinclude:: dgibi/08_biaxial.dgibi
      :language: gibiane
      :lines: 66
      :linenos:
      :lineno-start: 66

   .. literalinclude:: dgibi/08_biaxial.dgibi
      :language: gibiane
      :lines: 70-71
      :linenos:
      :lineno-start: 70

   .. literalinclude:: dgibi/08_biaxial.dgibi
      :language: gibiane
      :lines: 85-90
      :linenos:
      :lineno-start: 85

.. admonition:: Traction biaxiale : blocages

   .. literalinclude:: dgibi/08_biaxial.dgibi
      :language: gibiane
      :lines: 62-63
      :linenos:
      :lineno-start: 62

Les blocages et le chargement sont représentés sur la figure suivante.

.. image:: figures/mazars_biax_char_3d.png
   :width: 45%
.. image:: figures/mazars_biax_char_2d.png
   :width: 45%

Liste des exemples dgibi
""""""""""""""""""""""""
Les jeux de données Gibiane correspondants à ce cas de chargement sont téléchargeables aux liens suivants :

- :download:`Test pour la loi de Mazars <./dgibi/08_biaxial.dgibi>`
- :download:`Test pour la loi de RICBET <./dgibi/08_biaxial.dgibi>`


Triaxial
~~~~~~~~

Test de Willam
~~~~~~~~~~~~~~

