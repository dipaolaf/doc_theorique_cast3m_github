.. _sec:opti_topo_topoptim:

La procédure TOPOPTIM
=====================

La `procédure TOPOPIM <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPTIM>`_ de Cast3M
reprend l'algotithme 99 lignes de [SIGMUND-2001]_ :

- Le problème d'optimisation est celui de la **minimisation de la compliance** sous contrainte
  d'une **fraction volumique imposée**
- La :ref:`méthode de pénalisation SIMP <sec:opti_topo_simp>` est utilisée
- L'optimisation est réalisée par :ref:`critère d'optimalité <sec:opti_topo_oc>` et le multiplicateur
  de Lagrange (associé à la contrainte de volume) est calculé par dichotomie
- Le :ref:`filtrage de la sensibilité <sec:opti_topo_filtre>` est réalisé par convolution
- L'utilisateur peut imposer des **zones figées** qui feront obligatoirement partie de la topologie
  optimisée :math:`(x_e=1)`

De surcroît, elle élargie son cadre aux différents types de modélisation (2D/3D, maillages linéaires/quadratiques, tout type d'éléments, etc...) et dispose de fonctionnalités supplémentaires :

- L'utilisation de **maillages non structurés**
- L'application à des comportement mécaniques **non linéaires** (plasticité, contact, grands déplacements ...)
- La prise en compte de **chargements multiples**
- L'application à des problèmes **thermiques** et/ou **thermo mécaniques**
- La possibilité d'utiliser des **restrictions géométriques** avec des **symétries** (centrale, axiale et plane)
  ou des conditions de **pérodicité** (axiale ou circulaire)
- La prise en compte de **synthèse de mécanisme souple**

Étapes de la procédure
----------------------

La procédure `procédure TOPOPIM <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPTIM>`_ est segmentée en plusieurs étapes grace à des sous procédures spécifiques. Outre la facilité de la compréhension et de la maintenance, cette segmentation permet à l'utilisateur/développeur de pouvoir modifier la procédure facilment pour l'adapter à son propre problème d'optimisation.

- `TOPOBOOT <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOBOOT>`_
  pour le pré traitement des données. On y initialise une table de travail (indice `WTABLE`) contenant
  des indicateurs et valeurs des paramètres choisis par l'utilisateur ainsi que des variables de travail
  (champs unitaires, volumes élémentaires, etc).
  On initialise notament la topologie :math:`\textbf{x}` comme uniforme et égale à la fraction volumique imposée
  :math:`x_e=f`
- `TOPOINFO <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOINFO>`_
  pour afficher des informations sur le calcul en cours et les paramètres choisis
- Début de la **boucle d'optimisation**

  - `TOPOFCTR <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOFCTR>`_
    pour mettre à jour les paramètres d'amortissement/pénalisation et niveau de gris
  - procédure `TOPODENS <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPODENS>`_
    pour calculer les champs de densité pénalisés
  - procédure `TOPOACTI <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOACTI>`_
    pour mettre à jour les maillages/modèles/matériau/zone de contacts actifs. On procède notament au calcul du module d'Young pénalisé avec `TOPOMATE <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOMATE>`_

- `TOPORESO <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPORESO>`_
  pour résoudre le/les problèmes mécaniques/thermiques en appelant le solveur éléments finis
  de Cast3M (RESO pour des problèmes linéaires et PASAPAS pour les autres)
- `TOPOPERS <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPERS>`_
  pour permettre à l'utilisateur d'appeler une procédure personnelle
- `TOPOSENS <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOSENS>`_
  pour le calcul de la fonction objectif :math:`\psi(\textbf{x})` et du champ de sensibilité
  :math:`\dfrac{\partial\psi}{\partial x_e}`
- procédure `TOPORSTR <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPORSTR>`_
  pour appliquer les restrictions gémétriques
- procédure `TOPOFILT <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOFILT>`_
  pour appliquer le filtrage du champ de sensibilité (par convolution ou bien par interpolation avec les fonctions de forme)
- procédure `TOPOLOGY <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOLOGY>`_
  pour mettre à jour la topologie (selon le critère d'optimialité)
- procédure `TOPOSAUV <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOSAUV>`_
  pour sauvegarder les résultats
- Tracé (éventuel) de la topologie de l'itération courante
- Test de convergence (change < critère ou nbr max it atteint)
- Fin de boucle

