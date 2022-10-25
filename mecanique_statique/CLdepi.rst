.. _sec:mecanique_statique_CLdepi:

Conditions sur les déplacements
===============================

Relations linéaires entre inconnues de déplacement
--------------------------------------------------

En pratique, on a besoin de généraliser la condition de déplacement
imposé à des relations linéaires entre inconnues de déplacement, par
exemple, pour prescrire des conditions de symétrie. Ainsi, les
conditions sur les déplacements s'écrivent de façon plus générale :

.. math::

   A.U = d ,
   \label{eq:depi}

avec :math:`A`, la matrice des relations linaires entre inconnues de
déplacement, et :math:`d`, les valeurs imposées. Dans le cas d'une
condition de déplacement imposé usuelle, :math:`A` est la matrice
identité.

Traitement des conditions sur les déplacements
----------------------------------------------

Il existe principalement trois méthodes pour résoudre un système
linéaire avec des conditions imposées sur ses inconnues primales :

-  la méthode d'élimination ;

-  la méthode de pénalisation ;

-  la méthode des multiplicateurs de Lagrange.

Dans , on utilise formellement la méthode des multiplicateurs de
Lagrange.

Méthode des multiplicateurs de Lagrange
---------------------------------------

  Pour un système linéaire d'inconnue \ :math:`U` à résoudre tel que :

  .. math:: K^{e}.U=F^S + F^V - B.\sigma^{nl},

  l'ajout de :math:`n` conditions sur le champ solution équivaut à
  introduire :math:`n` inconnues supplémentaires :math:`\lambda`,
  appelées multiplicateurs de Lagrange, telles que :

  .. math::

     K^{e}.U + A^T.\lambda = F^S + F^V - B.\sigma^{nl} , \qquad \textrm{avec} \qquad A.U=d .
     \label{eq:statiqueLagrange1}

  L'équation (\ `[eq:statiqueEF4] <#eq:statiqueEF4>`__) permet
  d'identifier que le terme :math:`A^T.\lambda` est égal, au signe près,
  aux efforts de réaction aux déplacements imposés \ :math:`F^R`. La
  matrice :math:`A` étant sans dimension, les multiplicateurs de
  Lagrange sont homogènes à des efforts.
  On peut assembler ces deux équations sous forme matricielle :

  .. math::

     \left(
       \begin{array}{cc}
       K^{e} & A^T \\
       A      & 0
       \end{array}
     \right)
     \left(
       \begin{array}{c}
       U \\
       \lambda
       \end{array}
     \right)
     =
     \left(
       \begin{array}{c}
       F^S + F^V - B.\sigma^{nl} \\
       d
       \end{array}
     \right) ,

  pour expliciter formellement un seul système linéaire :

  .. math:: \hat{K}.\hat{U} = \hat{F} .

  La méthode des multiplicateurs de Lagrange permet de formaliser
  correctement le fait d'imposer des conditions sur les inconnues
  primales d'un système linéaire. Elle a toutefois le défaut d'accroître
  la taille du système à résoudre.
  Par ailleurs, la matrice :math:`\hat{K}` n'est pas toujours
  factorisable sans pivotage. Dans , on utilise la méthode des doubles
  multiplicateurs de Lagrange pour contourner cette difficulté. Pour
  plus de détails sur la mise en œuvre de cette méthode, on peut
  consulter l'article de `P. Verpeaux et T. Charras : << Multiplicateur
  de Lagrange, Condensation Statique et Conditions
  Unilatérales >> <http://www-cast3m.cea.fr/html/Articles/PV_CHAT_Giens2011_CondensationStatique.pdf>`__.

.. _operateurs_associes_2:

Opérateurs de Cast3M associés
-----------------------------

Dans , ce type de conditions est réalisé grâce aux opérateurs suivants :

-  :math:`A` : BLOQuer et RELAtion ;

-  :math:`d` : DEPI (DEPlacement Imposé) ;

-  :math:`\hat{K}` et :math:`\hat{F}` : ET, pour assembler les matrices
   :math:`K^{e}` et :math:`A` et les second membres
   (:math:`F^S+F^V-B.\sigma^{nl}`) et :math:`d` ;

-  :math:`\hat{U}` : RESOudre avec, comme arguments, :math:`\hat{K}` et
   :math:`\hat{F}`.
