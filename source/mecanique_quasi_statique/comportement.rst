.. _sec:meca_stat_comportement:

Comportement, équilibre et déplacements
=======================================

Loi de comportement
-------------------

La loi de comportement relie la contrainte :math:`\sigma` à la
déformation \ :math:`\mathcal{D} (u)` :

.. math::

   \sigma = \mathcal{C} \left( \mathcal{D} (u), \varepsilon^{in}, \upsilon, p \right)

:math:`\mathcal{D}` étant une mesure de la déformation du domaine
matériel, :math:`\varepsilon^{in}`, des déformations inélastiques,
:math:`\upsilon`, des variables internes, propres à la loi : variables
d'écrouissage, d'endommagement... et :math:`p`, un certain nombre de
paramètres externes : température, taux d'irradiation, etc.
Dans l'expression de la loi de comportement, on peut distinguer un
terme reliant linéairement la contrainte au déplacement, en associant
le comportement élastique linéaire de la structure à une mesure
linéaire de sa déformation, communément appelée mesure en petites
déformations :

.. math::
   :name: eq:meca_stat_LDCline

   \sigma = \mathcal{E} : {\nabla}_s u + \sigma^{nl}

- :math:`\mathcal{E}` étant le tenseur d'élasticité intervenant dans la loi de Hooke,

- :math:`\nabla_s u` le gradient symétrisé des déplacements,

- :math:`\sigma^{nl}` le terme non-linéaire complémentaire.

Relation force-déplacement
--------------------------

En injectant l'expression :eq:`eq:meca_stat_LDCline` dans la :ref:`formulation éléments finis <eq:meca_stat_statiqueEF1>`
de l'équilibre, nous obtenons :

.. math::

   \int_{\partial \Omega^h } t v_i \mathcal{N}_i dS + \int_{\partial \Omega^h_d} t_i v_i dS
     - \int_{\Omega^h} u_j \nabla \mathcal{N}_j \mathcal{E} \nabla \mathcal{N}_i v_i dV
     - \int_{\Omega^h} \sigma^{nl} v_i \nabla \mathcal{N}_i dV + \int_{\Omega^h} f v_i \mathcal{N}_i dV = 0

Ceci devant être vérifié quel que soit :math:`v`, nous pouvons simplifier
par :math:`v_i` pour obtenir :

.. math::

   \underbrace{\int_{\partial \Omega^h } t \mathcal{N} dS}_{F^S}
     + \underbrace{\int_{\partial \Omega^h_d} t \mathcal{N} dS}_{F^R}
     + \underbrace{\int_{\Omega^h} f \mathcal{N} dV}_{F^V}
     - \underbrace{\int_{\Omega^h} \sigma^{nl} \nabla \mathcal{N} dV}_{\mathcal{B}.\sigma^{nl}}
     = \underbrace{\int_{\Omega^h} u_j \nabla \mathcal{N}_j \mathcal{E} \nabla \mathcal{N}_i dV}_{\mathcal{K}^{e}.U}

:math:`\mathcal{K}^{e}` étant la raideur élastique et :math:`U`, le déplacement
aux noeuds du maillage. On obtient, finalement :

.. math::
   :name: eq:meca_stat_statiqueEF4
   
   \mathcal{K}^{e}.U = F^S + F^R + F^V - \mathcal{B}.\sigma^{nl}

Remarque sur les efforts intérieurs
-----------------------------------

En faisant passer le terme de gauche de cette dernière équation à droite
du signe égal, on obtient :

.. math:: F^S + F^R + F^V - \left(\mathcal{K}^{e}.U + \mathcal{B}.\sigma^{nl}\right) = 0

À l'aide de l':ref:`équation d'équilibre <eq:meca_stat_statiqueEF2>`, on identifie alors que :

.. math::
   :name: eq:meca_stat_bsigma

   \mathcal{B}.\sigma = \mathcal{K}^{e}.U + \mathcal{B}.\sigma^{nl}

soit l'équation :eq:`eq:meca_stat_LDCline` à laquelle on a appliqué l'opérateur
`BSIG <http://www-cast3m.cea.fr/index.php?page=notices&notice=BSIG>`_.

.. _meca_stat_operateurs_associes_1:

Opérateurs de Cast3M associés
-----------------------------

Dans Cast3M, les différents termes ci-dessus peuvent être obtenus avec les opérateurs suivants :

-  :math:`\mathcal{K}^{e}`   : `RIGI <http://www-cast3m.cea.fr/index.php?page=notices&notice=RIGI>`_ (rigidité) ;

-  :math:`\sigma`      : `COMP <http://www-cast3m.cea.fr/index.php?page=notices&notice=COMP>`_ (comportement) ;

-  :math:`\nabla_s u` : `EPSI <http://www-cast3m.cea.fr/index.php?page=notices&notice=EPSI>`_ (epsilon),
   correspondant aux déformations ;

-  :math:`\mathcal{E}`       : `ELAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=ELAS>`_ (élasticité suivant la loi de Hooke) ;

-  :math:`U`      : `RESO <http://www-cast3m.cea.fr/index.php?page=notices&notice=RESO>`_ (résoudre),
   en fournissant à l'opérateur la matrice de raideur :math:`\mathcal{K}^{e}` et le second membre
   (:math:`F^S+F^R+F^V-\mathcal{B}.\sigma^{nl}`) obtenu avec les opérateurs + et -.
