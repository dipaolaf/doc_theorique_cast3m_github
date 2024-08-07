.. _sec:modeles_beton_tableau_synthese:

Tableau synthétique des lois béton
==================================

Le tableau ci-desous résume les principales informations de l'ensemble des lois pour le béton
disponibles dans Cast3M. Une description plus détaillée est disponible dans les chapitres
suivants.

+---------------------+----------------+-----------------+-----------------------------------------+
| Loi de              | Éléments finis | Phénomènes      | Description                             |
|                     |                |                 |                                         |
| comportement        | disponibles    | modélisés       |                                         |
+=====================+================+=================+=========================================+
| **BILIN_MOMY**      | POUT           | Plasticité      | Loi bi-linéaire moment fléchissant-     |
|                     |                |                 | courbure                                |
|                     +                +                 +                                         +
|                     | TIMO           |                 | :math:`M_y(\Phi_y)`                     |
+---------------------+----------------+-----------------+-----------------------------------------+
| **BILIN_EFFZ**      | TIMO           | Plasticité      | Loi bi-linéaire effort tranchant-       |
|                     |                |                 | cisaillement                            |
|                     |                |                 +                                         +
|                     |                |                 | :math:`F_z(\Gamma_z)`                   |
+---------------------+----------------+-----------------+-----------------------------------------+
| **TAKEMO_MOMY**     | POUT           | Plasticité      | Loi tri-linéaire moment fléchissant-    |
|                     |                |                 | courbure                                |
|                     +                +                 +                                         +
|                     | TIMO           | Endommagement   | :math:`M_y(\Phi_y)`                     |
|                     |                +                 +                                         |
|                     |                | Cyclique        |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **TAKEMO_EFFZ**     | TIMO           | Plasticité      | Loi tri-linéaire effort tranchant-      |
|                     |                |                 | cisaillement                            |
|                     |                | Endommagement   |                                         |
|                     |                +                 +                                         |
|                     |                | Cyclique        | :math:`F_z(\Gamma_z)`                   |
+---------------------+----------------+-----------------+-----------------------------------------+
| **GLOBAL**          | POUT           | Plasticité      | Ensemble de 3 lois tri-linéaires        |
|                     |                +                 +                                         +
|                     |                |                 | axiale :math:`F_x`                      |
|                     |                |                 +                                         +
|                     |                |                 | flexion :math:`M_y` ou :math:`M_z`      |
|                     |                |                 +                                         +
|                     |                |                 | cisaillement :math:`F_y` ou :math:`F_z` |
|                     +                +                 +                                         |
|                     | TIMO           | Multi modes     |                                         |
|                     |                |                 |                                         |
|                     |                |                 |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **GAUVAIN**         | POUT           | Plasticité      | Lois moments fléchissants-              |
|                     |                |                 | courbures                               |
|                     +                +                 +                                         +
|                     | TIMO           |                 | :math:`M_y(\Phi_y)`                     |
|                     |                |                 |                                         |
|                     |                |                 | :math:`M_z(\Phi_z)`                     |
+---------------------+----------------+-----------------+-----------------------------------------+
| **CISAIL_NL**       | TIMO           | Plasticité      | Loi multi-linéaire adoucissante         |
|                     |                +                 +                                         +
|                     |                | Endommagement   | effort tranchant-cisaillement           |
|                     |                +                 +                                         +
|                     |                | Cyclique        | :math:`F_z(\Gamma_z)`                   |
|                     |                |                 |                                         |
|                     +----------------+-----------------+-----------------------------------------+
|                     | QUAS TRIS      | Plasticité      | Loi multi-linéaire adoucissante         |
|                     +                +                 +                                         +
|                     | SEGS POJS      | Endommagement   | contrainte tangentielle-cisaillement    |
|                     |                |                 +                                         +
|                     |                | Cyclique        | :math:`\sigma_{xz}(\gamma_{xz})`        |
|                     |                |                 |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **INFILL_UNI**      | BARR           | Plasticité      | Loi multi-linéaire adoucissante         |
|                     |                +                 +                                         +
|                     |                | Endommagement   | effort axial-élongation :math:`F_x(E_x)`|
|                     |                +                 +                                         +
|                     |                | Cyclique        | résistance nulle en traction            |
|                     |                |                 |                                         |
|                     |                |                 |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **BETON_BAEL**      | BARR           | Plasticité      | Loi non linéaire plastique unilatérale  |
|                     |                +                 +                                         +
|                     |                |                 | contrainte-déformation axiale           |
|                     +----------------+                 +                                         +
|                     | QUAS TRIS      |                 | :math:`\sigma_{xx}(\varepsilon_{xx})`   |
|                     |                |                 +                                         +
|                     | SEGS POJS      |                 | résistance nulle en traction            |
+---------------------+----------------+-----------------+-----------------------------------------+
| **BETON_UNI**       | BARR           | Plasticité      | Loi adoucissante uniaxiale de Hognestad |
|                     |                +                 +                                         +
|                     |                | Endommagement   | contrainte-déformation axiale           |
|                     +----------------+                 +                                         |
|                     | QUAS TRIS      | Confinement     | :math:`\sigma_{xx}(\varepsilon_{xx})`   |
|                     +                +                 +                                         +
|                     | SEGS POJS      | Refermeture     |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **FRAGILE_UNI**     | BARR           | Endommagement   | Loi hyperbolique adoucissante fragile   |
|                     |                |                 +                                         +
|                     +----------------+                 | contrainte-déformation axiale           |
|                     | QUAS TRIS      |                 +                                         +
|                     +                +                 | :math:`\sigma_{xx}(\varepsilon_{xx})`   |
|                     | SEGS POJS      |                 |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **UNILATERAL**      | QUAS TRIS      | Plasticité      | Loi adoucissante uniaxiale de Laborderie|
|                     +                +                 +                                         +
|                     | SEGS POJS      | Endommagement   | contrainte-déformation axiale           |
|                     |                +                 +                                         +
|                     |                | Cyclique        | :math:`\sigma_{xx}(\varepsilon_{xx})`   |
|                     |                +                 +                                         +
|                     |                | Refermeture     |                                         |
+---------------------+----------------+-----------------+-----------------------------------------+
| **MAZARS**          | QUAS TRIS      | Endommagement   | Loi adoucissante de Mazars              |
|                     +                +                 +                                         +
|                     | SEGS POJS      | Refermeture     | contrainte-déformation axiale           |
|                     |                |                 +                                         +
|                     |                |                 | :math:`\sigma_{xx}(\varepsilon_{xx})`   |
|                     |                |                 +                                         +
+---------------------+----------------+-----------------+-----------------------------------------+
