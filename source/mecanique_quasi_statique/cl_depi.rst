.. _sec:meca_stat_cl_depi:

Conditions sur les déplacements
===============================

Relations linéaires entre inconnues de déplacement
--------------------------------------------------

En pratique, on a besoin de généraliser la condition de déplacement
imposé à des relations linéaires entre inconnues de déplacement, par
exemple, pour prescrire des conditions de symétrie. Ainsi, les
conditions sur les déplacements s'écrivent de façon plus générale :

.. math::

   \mathcal{A}.U = d

avec :math:`\mathcal{A}`, la matrice des relations linaires entre inconnues de
déplacement, et :math:`d`, les valeurs imposées. Dans le cas d'une
condition de déplacement imposé usuelle, :math:`\mathcal{A}` est la matrice
identité.

Traitement des conditions sur les déplacements
----------------------------------------------

Il existe principalement trois méthodes pour résoudre un système
linéaire avec des conditions imposées sur ses inconnues primales :

-  la méthode d'élimination ;

-  la méthode de pénalisation ;

-  la méthode des multiplicateurs de Lagrange.

Dans Cast3M, on utilise formellement la méthode des multiplicateurs de Lagrange.

Méthode des multiplicateurs de Lagrange
---------------------------------------

Pour un système linéaire d'inconnue \ :math:`U` à résoudre tel que :

.. math:: \mathcal{K}^{e}.U=F^S + F^V - \mathcal{B}.\sigma^{\textrm{nl}}

l'ajout de :math:`n` conditions sur le champ solution équivaut à
introduire :math:`n` inconnues supplémentaires :math:`\lambda`,
appelées *multiplicateurs de Lagrange*, telles que :

.. math::
   :name: eq:meca_stat_statiqueLagrange1

   \mathcal{K}^{e}.U + \mathcal{A}^T.\lambda = F^S + F^V - \mathcal{B}.\sigma^{\textrm{nl}} \qquad \textsf{avec} \qquad \mathcal{A}.U=d

La précédente :ref:`relation force-déplacement <eq:meca_stat_statiqueEF4>` permet d'identifier
que le terme :math:`\mathcal{A}^T.\lambda` est égal, au signe près, aux efforts de réaction
aux déplacements imposés \ :math:`F^R`. La matrice :math:`\mathcal{A}` étant sans dimension,
les multiplicateurs de Lagrange sont homogènes à des efforts. On peut assembler ces
deux équations sous forme matricielle :

.. math::

   \left(
     \begin{array}{cc}
     \mathcal{K}^{e} & \mathcal{A}^T \\
     \mathcal{A}      & 0
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
     F^S + F^V - \mathcal{B}.\sigma^{\textrm{nl}} \\
     d
     \end{array}
   \right)

pour expliciter formellement un seul système linéaire :

.. math:: \hat{\mathcal{K}}.\hat{U} = \hat{F}

La méthode des multiplicateurs de Lagrange permet de formaliser
correctement le fait d'imposer des conditions sur les inconnues
primales d'un système linéaire. Elle a toutefois le défaut d'accroître
la taille du système à résoudre.
Par ailleurs, la matrice :math:`\hat{\mathcal{K}}` n'est pas toujours
factorisable sans pivotage. Dans , on utilise la méthode des doubles
multiplicateurs de Lagrange pour contourner cette difficulté. Pour
plus de détails sur la mise en œuvre de cette méthode, on peut
consulter l'article de `P. Verpeaux et T. Charras (congrès de Giens 2011) <http://www-cast3m.cea.fr/html/Articles/PV_CHAT_Giens2011_CondensationStatique.pdf>`_.

.. _meca_stat_operateurs_associes_2:

Opérateurs de Cast3M associés
-----------------------------

Dans Cast3M, ce type de conditions est réalisé grâce aux opérateurs suivants :

-  :math:`\mathcal{A}`          : `BLOQ <http://www-cast3m.cea.fr/index.php?page=notices&notice=BLOQ>`_ (bloquer)
   et `RELAtion <http://www-cast3m.cea.fr/index.php?page=notices&notice=RELA>`_ (relation) ;

-  :math:`d`           : `DEPI <http://www-cast3m.cea.fr/index.php?page=notices&notice=DEPI>`_ (DEPlacement Imposé) ;

-  :math:`\hat{\mathcal{K}}` et :math:`\hat{F}` : `ET <http://www-cast3m.cea.fr/index.php?page=notices&notice=ET>`_,
   pour assembler :math:`\mathcal{K}^{e}` et :math:`\mathcal{A}` ainsi que les second membres (:math:`F^S+F^V-\mathcal{B}.\sigma^{\textrm{nl}}`) et :math:`d` ;

-  :math:`\hat{U}`          : `RESO <http://www-cast3m.cea.fr/index.php?page=notices&notice=RESO>`_ (résoudre)
   avec, comme arguments, :math:`\hat{\mathcal{K}}` et :math:`\hat{F}`.
