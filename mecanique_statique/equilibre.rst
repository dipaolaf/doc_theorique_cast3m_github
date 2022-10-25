.. _sec:mecanique_statique_equilibre:

Équilibre mécanique
===================

Équation de la statique
-----------------------

  Soit un domaine matériel :math:`\Omega` soumis à une densité volumique
  d'efforts :math:`{f}`, une densité surfacique d'efforts :math:`{t}`
  sur son bord :math:`\partial\Omega_t` et des déplacements imposés
  :math:`{d}` sur son bord :math:`\partial\Omega_d`, avec
  :math:`\partial\Omega_t\cap\partial\Omega_d = \varnothing`.
  Dans le cadre de la mécanique des milieux continus, on dit que le
  domaine matériel :math:`\Omega` est en équilibre lorsque le système
  d'équations suivant est vérifié :

  .. math::

     \left\{
     \begin{array}{rcll}
       div\,\sigma + {f} & = & 0 &  \textrm{sur $\Omega$} \\
               {\sigma.n} & = & t & \textrm{sur $\partial\Omega_t$} \\
                        u & = & d & \textrm{sur $\partial\Omega_d$} \\
     \end{array}
     \right. ,
     %\label{eq:statiqueCL}
     \label{eq:statiquemmc}

  :math:`\sigma` et :math:`u` étant les champs de contrainte et de
  déplacement.

Formulation faible de l'équilibre
---------------------------------

En multipliant chaque terme de la première équation du
système (\ `[eq:statiquemmc] <#eq:statiquemmc>`__) par un champ de
déplacement virtuel :math:`v` non nul, puis en intégrant par partie sur
:math:`\Omega`, on obtient une formulation faible de l'équilibre :

.. math::

   \int_{\partial\Omega_t} t v dS + \int_{\partial\Omega_d} \sigma n v dS  
    - \int_{\Omega} \sigma \nabla v dV + \int_{\Omega} f v dV = 0 ,
   \label{eq:statiquefaible}

où l'on a remplacé le produit :math:`\sigma.n` par la densité surfacique
d'efforts \ :math:`t` sur :math:`\partial\Omega_t` et avec
:math:`\nabla v`, le gradient de :math:`v`.

Discrétisation par éléments finis
---------------------------------

On réalise un maillage :math:`\Omega^h` du domaine :math:`\Omega`. Sur
ce maillage, le champ de déplacement :math:`v` est discrétisé sur la
base des fonctions d'interpolation :math:`<N_i>` associées aux éléments
du maillage :

.. math::

   v^h(x) = \sum_i v_i N_i(x) ,
   \label{eq:discretEF}

:math:`v_i` ayant la valeur du déplacement :math:`v` au point :math:`i`
du maillage.

Formulation élément finis de l'équilibre
----------------------------------------

  En injectant cette discrétisation dans la formulation faible de
  l'équilibre (\ `[eq:statiquefaible] <#eq:statiquefaible>`__), nous
  obtenons :

  .. math::

     \int_{\partial\Omega^h_t} t v_i N_i dS + \int_{\partial \Omega^h_d} \sigma.n v_i N_i dS  
       - \int_{\Omega^h} \sigma v_i \nabla N_i dV + \int_{\Omega^h} f v_i N_i dV = 0 .
     \label{eq:statiqueEF1}

  Ceci devant être vérifié pout tout :math:`v`, nous vérifions, à chaque
  nœud :math:`i` du maillage, l'égalité suivante :

  .. math::

     \underbrace{\int_{\partial\Omega^h_t} t N dS}_{F^S}
       + \underbrace{\int_{\partial \Omega^h_d} \sigma.n N dS}_{F^R}
       + \underbrace{\int_{\Omega^h} f N dV}_{F^V}
       - \underbrace{\int_{\Omega^h} \sigma \nabla N dV}_{B.\sigma}
       = 0 ,

  où l'on a négligé l'indice :math:`i`.
  Cette dernière équation fait apparaitre les forces nodales
  équivalentes :

-  :math:`F^S` : à la densité surfacique d'efforts \ :math:`t` ;

-  :math:`F^R` : à la densité surfacique d'efforts de réaction aux
   déplacements imposés \ :math:`d` ;

-  :math:`F^V` : à la densité volumique d'efforts \ :math:`f` ;

-  :math:`B.\sigma` : à la densité volumique d'efforts intérieurs.

  On note que ces forces nodales équivalentes sont des quantités
  intégrées sur le maillage.
  La formulation << éléments finis >> de l'équilibre s'écrit donc :

  .. math::

     \underbrace{F^S + F^R + F^V}_{F^{ext}} \underbrace{- B.\sigma}_{F^{int}} = 0 ,
     \label{eq:statiqueEF2}

  :math:`F^{ext}` représentant les efforts extérieurs appliqués au
  domaine matériel :math:`\Omega` et :math:`F^{int}`, les efforts
  intérieurs.

.. _sec:residu:

Résidu
------

Les termes de l'équation
d'équilibre (\ `[eq:statiqueEF2] <#eq:statiqueEF2>`__) forment le
résidu :math:`R` :

.. math::

   R = F^S + F^R + F^V - B.\sigma .
   \label{eq:residu}

Numériquement, l'équilibre n'est satisfait que de façon approchée.
Ainsi, on peut considérer qu'il est atteint lorsqu'une norme de ce
résidu devient négligeable devant une valeur de référence des efforts
mis en jeu dans le problème considéré :

.. math:: 

  |R| < \zeta\, F^{ref} .

La valeur de :math:`\zeta` est fournie par l'utilisateur: c'est la précision du calcul.
La valeur de :math:`F^{ref}` peut être une norme des efforts extérieurs :math:`F^{ext}`.
Dans certains cas : dilatation libre, décharge... ces derniers peuvent être nuls à l'équilibre. L'utilisateur doit alors également préciser la valeur de :math:`F^{ref}` ou fournir une tolérance sur les
efforts : :math:`F^{tol} = \zeta\, F^{ref}`.
Si le problème fait intervenir des coques, poutres, tuyaux... il peut
aussi s'avérer nécessaire de fournir une tolérance sur les
moments \ :math:`M^{tol}`.

Opérateurs de Cast3M associés
-----------------------------

Les termes de l'équation (\ `[eq:statiqueEF2] <#eq:statiqueEF2>`__)
peuvent être obtenus à l'aide des opérateurs suivants de  :

-  :math:`F^S` : PRESsion, FORCe, FSUR (Force SURfacique)... selon le
   cas ;

-  :math:`F^R` : REACtions ;

-  :math:`F^V` : CNEQ (Charge Nodale EQuivalente) ;

-  :math:`B.\sigma` : BSIGma ;

-  :math:`F^{tol}`, :math:`M^{tol}` : voir entrées de la procédure
   PASAPAS.
