.. _sec:mecanique_statique_comportement:

Comportement, équilibre et déplacements
=======================================

Loi de comportement
-------------------

  La loi de comportement relie la contrainte :math:`\sigma` à la
  déformation \ :math:`\mathcal{D} (u)` :

  .. math::

     \sigma = \mathcal{C} \left( \mathcal{D} (u), \varepsilon^{in}, \upsilon, p \right),
     \label{eq:LDCgene}

  :math:`\mathcal{D}` étant une mesure de la déformation du domaine
  matériel, :math:`\varepsilon^{in}`, des déformations inélastiques,
  :math:`\upsilon`, des variables internes, propres à la loi : variables
  d'écrouissage, d'endommagement... et :math:`p`, un certain nombre de
  paramètres externes : température, taux d'irradiation, etc.
  Dans l'expression de la loi de comportement, on peut distinguer un
  terme reliant linéairement la contrainte au déplacement, en associant
  le comportement élastique linéaire de la structure à une mesure
  linéaire de sa déformation, communément appelée mesure en petites
  déformations :

  .. math::

     \sigma = \mathcal{E} : {\nabla}_s u + \sigma^{nl} ,
     \label{eq:LDCline}

  :math:`\mathcal{E}` étant le tenseur d'élasticité, :math:`\nabla_s u`,
  le gradient symétrisé des déplacements, et :math:`\sigma^{nl}`, le
  terme non-linéaire complémentaire.

Relation force-déplacement
--------------------------

En injectant l'expression (\ `[eq:LDCline] <#eq:LDCline>`__) dans la
formulation éléments finis de
l'équilibre (\ `[eq:statiqueEF1] <#eq:statiqueEF1>`__), nous obtenons :

.. math::

   \int_{\partial \Omega^h } t v_i N_i dS + \int_{\partial \Omega^h_d} t_i v_i dS
     - \int_{\Omega^h} u_j \nabla N_j \mathcal{E} \nabla N_i v_i dV
     - \int_{\Omega^h} \sigma^{nl} v_i \nabla N_i dV + \int_{\Omega^h} f v_i N_i dV = 0.
   \label{eq:statiqueEF3}

Ceci devant être vérifié quel que soit :math:`v`, nous pouvons
simplifier par :math:`v_i` pour obtenir :

.. math::

   \underbrace{\int_{\partial \Omega^h } t N dS}_{F^S}
     + \underbrace{\int_{\partial \Omega^h_d} t N dS}_{F^R}
     + \underbrace{\int_{\Omega^h} f N dV}_{F^V}
     - \underbrace{\int_{\Omega^h} \sigma^{nl} \nabla N dV}_{B.\sigma^{nl}}
     = \underbrace{\int_{\Omega^h} u_j \nabla N_j \mathcal{E} \nabla N_i dV}_{K^{e}.U} ,

:math:`K^{e}` étant la raideur élastique et :math:`U`, le déplacement
aux noeuds du maillage. On obtient, finalement :

.. math::

   K^{e}.U = F^S + F^R + F^V - B.\sigma^{nl} .
   \label{eq:statiqueEF4}

Remarque sur les efforts intérieurs
-----------------------------------

En faisant passer le terme de gauche de cette dernière équation à droite
du signe égal, on obtient :

.. math:: F^S + F^R + F^V - \left(K^{e}.U + B.\sigma^{nl}\right) = 0 .

À l'aide de l'équation
d'équilibre (\ `[eq:statiqueEF2] <#eq:statiqueEF2>`__), on identifie
alors que :

.. math::

   B.\sigma = K^{e}.U + B.\sigma^{nl} ,
   \label{eq:bsigma}

soit l'équation (\ `[eq:LDCline] <#eq:LDCline>`__) à laquelle on a
appliqué l'opérateur << BSIGma >>.

.. _operateurs_associes_1:

Opérateurs de Cast3M associés
-----------------------------

Dans, les différents termes ci-dessus peuvent être obtenus avec les
opérateurs suivants :

-  :math:`K^{e}` : RIGIdité ;

-  :math:`\sigma` : COMPortement ;

-  :math:`\nabla_s u` : EPSIlon, les déformations étant généralement
   notées \ :math:`\varepsilon` ;

-  :math:`\mathcal{E}:\ \varepsilon` : ELASticité ;

-  :math:`U` : RESOudre, en fournissant à l'opérateur la matrice de
   raideur :math:`K^{e}` et le second membre
   (:math:`F^S+F^R+F^V-B.\sigma^{nl}`) obtenu avec les opérateurs
   << + >> et << - >>.
