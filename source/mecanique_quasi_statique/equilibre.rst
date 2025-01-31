.. _sec:meca_stat_equilibre:

Équilibre mécanique
===================

Équations de la statique
------------------------

Soit un domaine matériel :math:`\Omega` soumis à une densité volumique
d'efforts :math:`{f}`, une densité surfacique d'efforts :math:`{t}`
sur son bord :math:`\partial\Omega_t` et des déplacements imposés
:math:`{d}` sur son bord :math:`\partial\Omega_d`, avec
:math:`\partial\Omega_t\cap\partial\Omega_d = \varnothing`.
Dans le cadre de la mécanique des milieux continus, on dit que le
domaine matériel :math:`\Omega` est en équilibre lorsque le système
d'équations suivant est vérifié :

.. math::
   :name: eq:meca_stat_statiquemmc

   \left\{
   \begin{array}{rcll}
     \textrm{div}\,\sigma + {f}  & = & 0 &  \textrm{sur $\Omega$} \\
                      {\sigma.n} & = & t & \textrm{sur $\partial\Omega_t$} \\
                               u & = & d & \textrm{sur $\partial\Omega_d$} \\
   \end{array}
   \right.

:math:`\sigma` et :math:`u` étant les champs de contrainte et de déplacement.

Formulation faible de l'équilibre
---------------------------------

En multipliant chaque terme de la première équation du système
:eq:`eq:meca_stat_statiquemmc` par un champ de déplacement virtuel :math:`v`
non nul, puis en intégrant par partie sur :math:`\Omega`,
on obtient une formulation faible de l'équilibre :

.. math::
   :name: eq:meca_stat_statiquefaible

   \int_{\partial\Omega_t} v^T.t dS + \int_{\partial\Omega_d} v^T.(\sigma . n) dS -
   \int_{\Omega} \nabla v.\sigma dV + \int_{\Omega} v^T.f dV = 0

où l'on a remplacé le vecteur contrainte :math:`\sigma.n` par la densité surfacique
d'efforts \ :math:`t` sur :math:`\partial\Omega_t` et avec :math:`\nabla v`, le gradient de :math:`v`.

Discrétisation par éléments finis
---------------------------------

On réalise un maillage :math:`\Omega^h` du domaine :math:`\Omega`. Sur ce maillage, le champ
de déplacement :math:`v` est discrétisé sur la base des fonctions d'interpolation :math:`\mathbfcal{N}` :

.. math::
   
   v^h(x) = \mathbfcal{N}(x).v = \sum_i \mathcal{N}_i(x) v_i

:math:`v_i` ayant la valeur du déplacement :math:`v` au point :math:`i` du maillage.

Formulation élément finis de l'équilibre
----------------------------------------

En injectant cette discrétisation dans la formulation faible de l'équilibre :eq:`eq:meca_stat_statiquefaible`, nous obtenons
en tout noeud :math:`i` :

.. math::
   :name: eq:meca_stat_statiqueEF1

   \int_{\partial\Omega^h_t} \mathcal{N}_i v_i \,t dS + \int_{\partial \Omega^h_d} \mathcal{N}_i v_i (\sigma.n) dS -
   \int_{\Omega^h} \nabla \mathcal{N}_i v_i \,\sigma dV + \int_{\Omega^h} \mathcal{N}_i v_i \,f dV = 0

Ceci devant être vérifié pout tout champ :math:`v`, nous vérifions alors l'égalité suivante :

.. math::
   :name: eq:meca_stat_statiqueEF2

   \underbrace{\int_{\partial\Omega^h_t} \mathbfcal{N}^T.t \,dS}_{F^S} +
   \underbrace{\int_{\partial \Omega^h_d} \mathbfcal{N}^T.(\sigma.n) dS}_{F^R} -
   \underbrace{\int_{\Omega^h} \nabla\mathbfcal{N}^T.\sigma dV}_{\mathbfcal{B}.\sigma} +
   \underbrace{\int_{\Omega^h} \mathbfcal{N}^T.f dV}_{F^V} = 0

où l'on est passé en notation matricielle. Cette dernière équation fait apparaitre les forces nodales équivalentes :

-  :math:`F^S` : à la densité surfacique d'efforts \ :math:`t` ;

-  :math:`F^R` : à la densité surfacique d'efforts de réaction aux
   déplacements imposés \ :math:`d` ;

-  :math:`F^V` : à la densité volumique d'efforts \ :math:`f` ;

-  :math:`\mathbfcal{B}.\sigma` : à la densité volumique d'efforts intérieurs.

On note que ces forces nodales équivalentes sont des quantités
intégrées sur le maillage.

La formulation *éléments finis* de l'équilibre s'écrit donc :

.. math::
   :name: eq:meca_stat_statiqueEF3

   \underbrace{F^S + F^R + F^V}_{F^{\textrm{ext}}} \; \underbrace{- \mathbfcal{B}.\sigma}_{F^{\textrm{int}}} = 0

:math:`F^{\textrm{ext}}` représentant les efforts extérieurs appliqués au
domaine matériel :math:`\Omega` et :math:`F^{\textrm{int}}`, les efforts
intérieurs.

.. _sec:meca_stat_residu:

Résidu
------

Les termes de l'équation d'équilibre :eq:`eq:meca_stat_statiqueEF3` forment le résidu :math:`R` :

.. math::

   R = F^S + F^R + F^V - \mathbfcal{B}.\sigma

Numériquement, l'équilibre n'est satisfait que de façon approchée.
Ainsi, on peut considérer qu'il est atteint lorsqu'une norme de ce
résidu devient négligeable devant une valeur de référence des efforts
mis en jeu dans le problème considéré :

.. math:: 

  |R| < \zeta\, F^{\textrm{ref}}

La valeur de :math:`\zeta` est fournie par l'utilisateur : c'est la *précision* du calcul.

La valeur de :math:`F^{\textrm{ref}}` peut être une norme des efforts extérieurs :math:`F^{\textrm{ext}}`.
Dans certains cas (dilatation libre, décharge...) ces derniers peuvent être nuls à l'équilibre.
L'utilisateur doit alors également préciser la valeur de :math:`F^{\textrm{ref}}` ou fournir une tolérance sur les
efforts : :math:`F^{\textrm{tol}} = \zeta\, F^{\textrm{ref}}`.

Si le problème fait intervenir des coques, poutres, tuyaux... il peut
aussi s'avérer nécessaire de fournir une tolérance sur les moments \ :math:`M^{\textrm{tol}}`.

Opérateurs de Cast3M associés
-----------------------------

Les termes de l'équation :eq:`eq:meca_stat_statiqueEF2` peuvent être obtenus à l'aide des
opérateurs suivants :

-  :math:`F^S`    : `PRES <http://www-cast3m.cea.fr/index.php?page=notices&notice=PRES>`_ (pression),
   `FORC <http://www-cast3m.cea.fr/index.php?page=notices&notice=FORC>`_ (force ponctuelle),
   `FSUR <http://www-cast3m.cea.fr/index.php?page=notices&notice=FSUR>`_ (force surfacique), ... selon le cas

-  :math:`F^R`   : `REAC <http://www-cast3m.cea.fr/index.php?page=notices&notice=REAC>`_ (réaction)

-  :math:`F^V`   : `CNEQ <http://www-cast3m.cea.fr/index.php?page=notices&notice=CNEQ>`_ (forces de volume)

-  :math:`\mathbfcal{B}.\sigma` : `BSIG <http://www-cast3m.cea.fr/index.php?page=notices&notice=BSIG>`_ (forces intérieurs)

-  :math:`F^{\textrm{tol}}`, :math:`M^{\textrm{tol}}` : voir entrées de la procédure
   `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_
