.. _sec:meca_stat_comportement:

Comportement, équilibre et déplacements
=======================================

Loi de comportement
-------------------

La loi de comportement relie la contrainte :math:`\sigma` à la
déformation \ :math:`\mathcal{D} (u)` :

.. math::

   \sigma = \mathcal{C} \left( \mathcal{D} (u), \varepsilon^{\textrm{in}}, \upsilon, p \right)

:math:`\mathcal{D}` étant une mesure de la déformation du domaine
matériel, :math:`\varepsilon^{\textrm{in}}`, des déformations inélastiques,
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

   \sigma = \mathbfcal{E} : {\nabla}_s u + \sigma^{\textrm{nl}}

- :math:`\mathbfcal{E}` étant le tenseur d'élasticité intervenant dans la loi de Hooke ;

- :math:`\nabla_s u` le gradient symétrisé des déplacements ;

- :math:`\sigma^{\textrm{nl}}` le terme non-linéaire complémentaire.

Relation force-déplacement
--------------------------

En injectant l'expression :eq:`eq:meca_stat_LDCline` dans la :ref:`formulation éléments finis <eq:meca_stat_statiqueEF3>`
de l'équilibre et en sortant le vecteur des déplacements nodaux :math:`U` de l'intégrale, nous obtenons :

.. math::

   \begin{align}
     \underbrace{\int_{\partial \Omega^h_t} \mathbfcal{N}^T.t dS}_{F^S} +
     \underbrace{\int_{\partial \Omega^h_d} \mathbfcal{N}^T.(\sigma.n) dS}_{F^R} -
     \underbrace{\int_{\Omega^h} \nabla \mathbfcal{N}^T \sigma^{\textrm{nl}} dV}_{\mathbfcal{B}.\sigma^{\textrm{nl}}} +
     \underbrace{\int_{\Omega^h} \mathbfcal{N}^T.f dV}_{F^V}\\
     = \underbrace{\int_{\Omega^h} \nabla \mathbfcal{N}^T.\mathbfcal{E}.\nabla \mathbfcal{N} dV}_{\mathbfcal{K}^{e}}.U
   \end{align}

:math:`\mathbfcal{K}^{e}` étant la raideur élastique et :math:`U` le déplacement aux noeuds du maillage. On obtient, finalement :

.. math::
   :name: eq:meca_stat_statiqueEF4
   
   \mathbfcal{K}^{e}.U = F^S + F^R + F^V - \mathbfcal{B}.\sigma^{\textrm{nl}}

Remarque sur les efforts intérieurs
-----------------------------------

En faisant passer le terme de gauche de cette dernière équation à droite
du signe égal, on obtient :

.. math:: F^S + F^R + F^V - \left(\mathbfcal{K}^{e}.U + \mathbfcal{B}.\sigma^{\textrm{nl}}\right) = 0

À l'aide de l':ref:`équation d'équilibre <eq:meca_stat_statiqueEF3>`, on identifie alors que :

.. math::
   :name: eq:meca_stat_bsigma

   \mathbfcal{B}.\sigma = \mathbfcal{K}^{e}.U + \mathbfcal{B}.\sigma^{\textrm{nl}}

soit l'équation :eq:`eq:meca_stat_LDCline` à laquelle on a appliqué l'opérateur
`BSIG <http://www-cast3m.cea.fr/index.php?page=notices&notice=BSIG>`_.

.. _meca_stat_operateurs_associes_1:

Opérateurs de Cast3M associés
-----------------------------

Dans Cast3M, les différents termes ci-dessus peuvent être obtenus avec les opérateurs suivants :

-  :math:`\mathbfcal{K}^{e}`   : `RIGI <http://www-cast3m.cea.fr/index.php?page=notices&notice=RIGI>`_ (rigidité) ;

-  :math:`\sigma`      : `COMP <http://www-cast3m.cea.fr/index.php?page=notices&notice=COMP>`_ (comportement) ;

-  :math:`\nabla_s u` : `EPSI <http://www-cast3m.cea.fr/index.php?page=notices&notice=EPSI>`_ (epsilon) correspondant aux déformations linéarisées ;

-  :math:`\mathbfcal{E}`       : `ELAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=ELAS>`_ (élasticité suivant la loi de Hooke) ;

-  :math:`U`      : `RESO <http://www-cast3m.cea.fr/index.php?page=notices&notice=RESO>`_ (résoudre) en fournissant à l'opérateur la matrice
   de raideur :math:`\mathbfcal{K}^{e}` et le terme au second membre (:math:`F^S+F^R+F^V-\mathbfcal{B}.\sigma^{\textrm{nl}}`).
