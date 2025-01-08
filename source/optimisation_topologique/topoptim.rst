.. _sec:opti_topo_topoptim:

La procédure TOPOPTIM
=====================

La procédure `TOPOPIM <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPTIM>`_ de Cast3M
reprend l'algotithme 99 lignes de [SIGMUND-2001]_ :

- Le problème d'optimisation est celui de la **minimisation de la compliance** sous contrainte d'une **fraction volumique imposée**
- La :ref:`méthode de pénalisation SIMP <sec:opti_topo_simp>` est utilisée
- L'optimisation est réalisée par :ref:`critère d'optimalité <sec:opti_topo_oc>` et le multiplicateur de Lagrange
  (associé à la contrainte de volume) est calculé par dichotomie
- Le :ref:`filtrage de la sensibilité <sec:opti_topo_filtre>` est réalisé par convolution
- L'utilisateur peut imposer des **zones figées** qui feront obligatoirement partie de la topologie optimisée :math:`(x_e=1)`

De surcroît, elle élargie son cadre d'application à différents types de modélisation (2D/3D, maillages linéaires/quadratiques,
tout type d'éléments, etc...) et dispose de fonctionnalités supplémentaires :

- L'utilisation de **maillages non structurés** et contenant plusieurs types d'éléments
- L'application à des comportements mécaniques **non linéaires** (plasticité, contact, grands déplacements ...)
- La prise en compte de **plusieurs cas de chargements**. L'utilisateur peut définir un nombre :math:`N_c` de problèmes à
  résoudre et minimiser une fonctionnelle sommant les compliances
- L'application à des problèmes **thermiques** et/ou **thermo mécaniques**. Dans ce second cas, les compliances mécaniques
  :math:`\psi^{\textrm{méca}}` et thermiques :math:`\psi^{\textrm{ther}}` sont pondérées et additionnées
- La possibilité d'utiliser des **restrictions géométriques** avec des *symétries* (centrale, axiale et plane) ou des
  *conditions de pérodicité* (axiale ou circulaire)
- La possibilité de faire évoluer les paramètres au cours des itérations de l'optimisation
- La prise en compte de **synthèse de mécanisme souple**

Quelques définitions
--------------------

La fonction objectif pour un problème mécanique est la **compliance** qui correspond au travail des forces extérieures,
ou aussi à l'énergie de déformation :

.. math::
   :name: eq:objectif_meca

   \psi^{\textrm{méca}}(\textbf{x}) = \textbf{U}^T(\textbf{x}).\mathbfcal{K}(\textbf{x}).\textbf{U}(\textbf{x}) = \int_{\Omega} \sigma(\textbf{x}):\varepsilon(\textbf{x}) dV

La fonction objectif pour un problème thermique est construite de manière similaire à celle de la mécanique :

.. math::
   :name: eq:objectif_ther

   \psi^{\textrm{ther}}(\textbf{x}) = \Theta^T(\textbf{x}).\mathbfcal{\Lambda}(\textbf{x}).\Theta(\textbf{x}) = \int_{\Omega} \phi(\textbf{x}).\textrm{grad}\,\Theta(\textbf{x}) dV

avec :

- :math:`\Theta` le vecteur des températures aux noeuds du maillage
- :math:`\mathbfcal{\Lambda}` la matrice de conductivité globale, assemblée sur le maillage
- :math:`\lambda` la conductivité thermique
- :math:`\textrm{grad}\, \Theta` le gradient de température dans les éléments
- :math:`\phi = -\lambda\,\textrm{grad}\, \Theta` la densité de flux thermique dans les éléments

Étapes de la procédure
----------------------

La procédure `TOPOPIM <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPTIM>`_ est segmentée en plusieurs étapes
avec des sous procédures spécifiques. Outre la facilité de la compréhension et de la maintenance, cette segmentation permet
à l'utilisateur/développeur de pouvoir modifier la procédure facilment pour l'adapter à son propre problème d'optimisation.

Les étapes sont les suivantes :

* **Pré traitement** (procédure `TOPOBOOT <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOBOOT>`_)

  On initialise une table de travail (indice **WTABLE**) contenant les indicateurs et les valeurs des paramètres
  choisis par l'utilisateur ainsi que des variables de travail (champs unitaires, volumes élémentaires, etc).
  On initialise notament la topologie :math:`\textbf{x}` comme uniforme et égale à la fraction volumique imposée :math:`x_e=f`

* **Informations** (procédure `TOPOINFO <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOINFO>`_)

  Il s'agit d'afficher les informations principales du calcul.

* **Début de la boucle d'optimisation :**

  1. **Évolution des paramètres** (procédure `TOPOFCTR <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOFCTR>`_)

     On fait évoluer les principaux coefficients (d'amortissement, de pénalisation et de niveau de gris) au cours des itérations,
     à condition que l'utilisateur ai fourni une liste de valeurs pour ces coefficients en fonction du numéro d'itération.

  2. **Pénalisation des densités** (procédure `TOPODENS <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPODENS>`_)

     On calcule les champs de *densité pénalisées* :math:`\tilde{\textbf{x}}` selon la topologie courante :math:`\textbf{x}`,
     le coefficient de pénalisation :math:`p` et la raideur minimale :math:`E_{\textrm{min}}` et/ou la conductivité minimale
     :math:`\lambda_{\textrm{min}}` :

     .. math::
      :name: eq:maj_dens

      \tilde{x}_e^{\textrm{méca}}& =\frac{E_{\textrm{min}}}{E_0}+\left(1-\frac{E_{\textrm{min}}}{E_0}\right)x_e^p \\
      \tilde{x}_e^{\textrm{ther}}& =\frac{\lambda_{\textrm{min}}}{\lambda_0}+\left(1-\frac{\lambda_{\textrm{min}}}{\lambda_0}\right)x_e^p

  3. **Mise à jour des zones actives et matériau** (procédure `TOPOACTI <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOACTI>`_)

     On met à jour les *zones actives* du maillage et des modèles. Il s'agit des éléments où la densité pénalisée
     :math:`\tilde{x}_e` est supérieure à un *seuil d'activation* :math:`x_a`. Les modèles et caractéristiques sont alors
     réduits sur le maillage actif. Les caractéristiques matériau sont également mises à jour selon la densité pénalisée avec
     la procédure `TOPOMATE <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOMATE>`_ :

     .. math::
      :name: eq:maj_mate

      \tilde{E}_e       & =       E_0 \tilde{x}_e^{\textrm{méca}} \\
      \tilde{\lambda}_e & = \lambda_0 \tilde{x}_e^{\textrm{ther}}

  4. **Résolution du problème physique** (procédure `TOPORESO <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPORESO>`_).

     La résolution du problème mécanique et/ou thermique se fait soit avec le solveur RESO (problème linéaire),
     soit avec PASAPAS (problème non linéaire). S'il y a plusieurs cas de chargements, les :math:`N_c` problèmes sont
     tous résolus successivement.

  5. **Instructions personnelles** (optionnel, procédure `TOPOPERS <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOPERS>`_)

     Il s'agit d'un point de branchement donné à l'utilisateur pour faire appel à une procédure personnelle et ajouter des
     instructions supplémentaires, ou bien remplacer une procédure et ainsi modifier l'algorithme.

  6. **Objectif et sensibilités** (procédure `TOPOSENS <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOSENS>`_)

     On calcule la fonction objectif :math:`\psi(\tilde{\textbf{x}})` ainsi que le champ de sensibilité
     :math:`\frac{\partial\psi}{\partial \tilde{x}_e}`. S'il y a un plusieurs cas de chargement, les :math:`N_c`
     objectifs/sensibilités sont sommés. Dans le cas thermo mécanique, les complicances des deux physiques sont donc aussi sommées
     mais peuvent être pondérées différement par les coefficients :math:`\omega^{\textrm{méca}}` et :math:`\omega^{\textrm{ther}}` :

     .. math::
      :name: eq:som_objectif

      \psi(\tilde{\textbf{x}}) = \frac{1}{N_c} \sum_{i=1}^{N_c} \left( \omega^{\textrm{méca}} \psi_i^{\textrm{méca}}(\tilde{\textbf{x}}) + \omega^{\textrm{ther}} \psi_i^{\textrm{ther}}(\tilde{\textbf{x}}) \right)

     .. math::
      :name: eq:som_sensibilite

      \frac{\partial\psi}{\partial \tilde{x}_e} = \frac{1}{N_c} \sum_{i=1}^{N_c} \left( \omega^{\textrm{méca}} \frac{\partial\psi_i^{\textrm{méca}}}{\partial \tilde{x}_e} + \omega^{\textrm{ther}} \frac{\partial\psi_i^{\textrm{ther}}}{\partial \tilde{x}_e} \right)

  7. **Restrictions géométriques** (procédure `TOPORSTR <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPORSTR>`_)

  8. **Filtrage** (procédure `TOPOFILT <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOFILT>`_)

     Le filtrage de la sensibilité peut être réalisé selon 2 méthodes :

     - Le filtre `GIBIANE` qui procède par des applications successives de l'opérateur
       `CHAN 'CHPO' <https://www-cast3m.cea.fr/index.php?page=notices&notice=CHAN#Resultat%20de%20type%20CHPOINT03>`_ puis
       `CHAN 'CHAM' <https://www-cast3m.cea.fr/index.php?page=notices&notice=CHAN#Resultat%20de%20type%20MCHAML04>`_
       sur le champ :math:`\tilde{x}_e \frac{\partial\psi}{\partial \tilde{x}_e}` ayant pour effet de le lisser
     - Le filtre `MATRICE` qui applique une *convolution* :ref:`(décrite ici) <sec:opti_topo_filtre>` sur le champ
       :math:`\tilde{x}_e \frac{\partial\psi}{\partial \tilde{x}_e}` via l'opérateur
       `MFIL <https://www-cast3m.cea.fr/index.php?page=notices&notice=MFIL>`_ et correspond au filtrage habituellement
       utilisé, notamment dans [SIGMUND-2001]_

  9. **Optimisation de la topologie** (procédure `TOPOLOGY <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOLOGY>`_)

     La mise à jour de la topologie :math:`\textbf{x}` s'effectue selon un algorithme de *critère d'optimalité*
     :ref:`(décrit ici) <sec:opti_topo_oc>` où le calcul du multiplicateur de Lagrange est fait par *dichotomie*
     :ref:`(décrit ici) <algo:opti_topo_dichotomie>`.

  10. **Sauvegarde des résultats** (procédure `TOPOSAUV <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOSAUV>`_)

  11. **Tracé et infos** éventuel de la topologie et affichage des informations sur l'itération courante

  12. **Test de convergence**

      La boucle d'optimisation est quittée si l'*incrément maximal de densité* entre deux itérations est inférieur au
      critère :math:`Z_{\textrm{stop}}`, ou bien si le nombre maximal d'itérations :math:`N_{\textrm{it}}` est atteint.

* **Fin de la boucle d'optimisation**

Variables/paramètres et indices de la table de calcul
-----------------------------------------------------

Le tableau ci-dessous fait la correspondance entre les variables/paramètres des problèmes d'optimisation présentées ici
et les indices de la table de calcul utilisée par `TOPOPTIM <https://www-cast3m.cea.fr/index.php?page=notices&notice=TOPOPTIM>`_.
Certaines grandeurs sont stockées directement dans la table car elles sont fixes ou bien sont des résultats de calcul rendus
à l'utilisateur, d'autres sont stockées dans la sous table **WTABLE** car elles sont mises à jour à chaque itération et sont
des intermédiaires de calcul temporaires.

Les valeurs choisies par défaut de certains paramètres sont également indiquées. Ce tableau n'est pas une liste exhaustive de
la table, le lecteur intéressé peut consulter le code de la procédure
`TOPOBOOT <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TOPOBOOT>`_ qui initialise cette table.

.. table:: Variables/paramètres et indices de la table de calcul
   :align: center

   +-----------------------------------------------------+----------------------------------+-------------------+
   | Variable / Paramètre                                | Indice dans la table             | Valeur par défaut |
   +=====================================================+==================================+===================+
   | :math:`x_e`                                         | **WTABLE . TOPOLOGIE**           |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\tilde{x}_e^{\textrm{méca}}`                 | **WTABLE . MECANIQUE . DENSITE** |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\tilde{x}_e^{\textrm{ther}}`                 | **WTABLE . THERMIQUE . DENSITE** |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`f`                                           | **FRACTION_VOLUME**              | 0,4               |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`p`                                           | **WTABLE . FACTEUR_P**           | 3                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\eta`                                        | **WTABLE . FACTEUR_D**           | 0,5               |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`x_\textrm{min}`                              | **TOPOLOGIE_MIN**                | 0                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`m`                                           | **TOPOLOGIE_MAX_INC**            | 0,2               |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\frac{E_{\textrm{min}}}{E_0}`                | **RAPPORT_RAIDEURS_MECANIQUES**  | 10\ :sup:`-8`     |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\frac{\lambda_{\textrm{min}}}{\lambda_0}`    | **RAPPORT_RAIDEURS_THERMIQUES**  | 10\ :sup:`-3`     |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\omega^{\textrm{méca}}`                      | **POIDS_ENERGIE_DEFO**           | 1                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\omega^{\textrm{ther}}`                      | **POIDS_TEMPERATURE**            | 1                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`N_c`                                         | **WTABLE . NB_CAS**              | 1                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`x_a`                                         | **SEUIL**                        | 10\ :sup:`-9`     |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`r_\textrm{min}`                              | **FILTRE_RAYON**                 |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`q`                                           | **FILTRE_EXPOSANT**              | 1                 |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\psi`                                        | **WTABLE . OBJECTIF**            |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`\dfrac{\partial\psi}{\partial \tilde{x}_e}`  | **WTABLE . SENSIBILITE**         |                   |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`Z_{\textrm{stop}}`                           | **CRITERE**                      | 0,01              |
   +-----------------------------------------------------+----------------------------------+-------------------+
   | :math:`N_{\textrm{it}}`                             | **MAX_CYCLES**                   | 100               |
   +-----------------------------------------------------+----------------------------------+-------------------+
