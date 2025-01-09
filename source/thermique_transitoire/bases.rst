.. _sec:ther_trans_bases:

Équations de la thermique
=========================

Équation locale de la chaleur
-----------------------------

**L'équation de la chaleur**, en tout point :math:`x` d'un domaine matériel :math:`\Omega`, s'écrit :

.. math::
   :name: eq:ther_chaleur_1

   \frac{\partial H}{\partial t} + \vec{\nabla}.\vec{\phi} = q

avec :

- :math:`H(T)` l'enthalpie volumique (en J.m\ :sup:`-3`)
- :math:`\vec{\phi}(T,t)` la densité de flux thermique (en W.m\ :sup:`-2`)
- :math:`q(T,t)` la puissance volumique, terme source (en W.m\ :sup:`-3`)
- :math:`t` le temps (en s)
- :math:`T(x,t)` la température (en K), principale inconnue du problème

**L'enthalpie volumique** :math:`H` ne dépend que de la température, on peut donc écrire :

.. math::
   :name: eq:ther_enthalpie_1

   \frac{\partial H}{\partial t} = \frac{\partial H}{\partial T} \frac{\partial T}{\partial t} = \rho c_p \frac{\partial T}{\partial t}

avec :

- :math:`\rho` la masse volumique (en kg.m\ :sup:`-3`)
- :math:`c_p` la capacité thermique massique (en J.kg\ :sup:`-1`.K\ :sup:`-1`)

**Le flux thermique** :math:`\vec{\phi}` est relié au gradient de température par la *loi de Fourier* :

.. math::

   \vec{\phi}=-\lambda \vec{\nabla} T

où :math:`\lambda` est la conductivité thermique (en W.m\ :sup:`-1`.K\ :sup:`-1`)

Dans le cas où il n'y a pas de changement de phase et où les caractéristiques ne dépendent pas de la température,
l'équation de la chaleur devient :

.. math::
   :name: eq:ther_chaleur_2

   \rho c_p \frac{\partial T}{\partial t} - \vec{\nabla}.\left(\lambda \vec{\nabla}T\right) = q

Conditions aux limites
----------------------

Les *conditions aux limites* peuvent porter soit sur la température :math:`T` :

.. math::
   :name: eq:ther_cl_timp_1

   T=T_{\textrm{imp}} \quad \textsf{sur } \Gamma_T

soit sur le flux :math:`\vec{\phi}` à travers un bord de normale :math:`\vec{n}` :

.. math::
   :name: eq:ther_cl_fimp

   \begin{align}
     \vec{\phi}.\vec{n} & = \phi_{\textrm{imp}}                     & \textsf{sur } & \Gamma_{\phi} & \textsf{flux imposé} \\
     \vec{\phi}.\vec{n} & = h(T_f - T)                              & \textsf{sur } & \Gamma_c      & \textsf{convection}  \\
     \vec{\phi}.\vec{n} & = \varepsilon \sigma (T_{\infty}^4 - T^4) & \textsf{sur } & \Gamma_r      & \textsf{rayonnement} \\
   \end{align}

avec :

- :math:`h` le coefficient d'échange (en W.m\ :sup:`-2`.K\ :sup:`-1`)
- :math:`T_f` la température du fluide en paroi (en K)
- :math:`T_{\infty}` la température à l'infini (en K)
- :math:`\varepsilon` l'émissivité de la surface
- :math:`\sigma` la constante de Stefan-Boltzmann (égale à en 5,67 10\ :sup:`-8` W.m\ :sup:`-2`.K\ :sup:`-4`)

Formulation éléments finis
--------------------------

Formulation faible
^^^^^^^^^^^^^^^^^^

En multipliant chaque terme de l'équation :eq:`eq:ther_chaleur_1` par un champ de température virtuel :math:`\tau`
non nul, puis en intégrant par partie sur :math:`\Omega`, on obtient une formulation faible de l'équation de la chaleur :

.. math::
   :name: eq:ther_form_faib_1

   \int_{\Omega} \left(\frac{\partial H}{\partial T}\frac{\partial T}{\partial t}\right)\tau d\Omega - \int_{\Omega} \lambda \vec{\nabla}T.\vec{\nabla}\tau d\Omega + \int_{\Gamma} \left(\lambda \vec{\nabla}T\right).\vec{n}\tau d\Gamma

L'intégrale sur le bord :math:`\Gamma` peut se réduire aux bords portant les conditions aux limites :eq:`eq:ther_cl_fimp` de flux imposé :

.. math::
   :name: eq:ther_form_faib_2

   \int_{\Gamma} \left(\lambda \vec{\nabla}T\right).\vec{n}\tau d\Gamma = - \int_{\Gamma_{\phi}}\phi_{\textrm{imp}}\tau d\Gamma_{\phi} - \int_{\Gamma_c}h(T_f-T)\tau d\Gamma_c - \int_{\Gamma_r}\varepsilon\sigma(T_{\infty}^4-T^4)\tau d\Gamma_r

Le terme du rayonnement peut être ramené à un terme de convection en faisant l'approximation suivante :

.. math::
   :name: eq:ther_approx_rayo

   T_{\infty}^4-T^4 = (T_{\infty}-T)(\tilde{T}^3 + \tilde{T}^2 T_{\infty} + \tilde{T} T_{\infty}^2 + T_{\infty}^3)

Cette approximation, permettant de linéariser le flux en fonction de :math:`T`, n'est valable qu'au voisinage de la
température :math:`\tilde{T}`.

Discrétisation par éléments finis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

En discrétisant l'espace :math:`\Omega` par un maillage, les températures :math:`T` et :math:`\tau` sont discrétisées sur la
base des fonctions d'interpolation :math:`\mathbfcal{N}` :

.. math::

   T(x,t) = \mathbfcal{N}(x).T(t) = \sum_i \mathcal{N}_i(x) T_i(t)

:math:`T` désignant maintenant le **vecteur des températures aux noeuds** et :math:`T_i` la valeur de la température au noeud :math:`i` du maillage.
En injectant cette discrétisation dans la formulation faible :eq:`eq:ther_form_faib_1`, nous obtenons le système matriciel pour tout instant :math:`t` :

.. math::
   :name: eq:ther_ef_1

   \mathbfcal{C}(T).\dot{T} + \mathbfcal{K}(T).T = Q

:math:`\mathbfcal{C}` est la **matrice de capacité** :

.. math::
   :name: eq:ther_capa

   \mathbfcal{C}(T) = \int_{\Omega} \mathbfcal{N}^T.\left(\frac{\partial H}{\partial T}\frac{\partial T}{\partial t}\right).\mathbfcal{N} d\Omega

:math:`\mathbfcal{K}` est la **matrice de conductivité** :

.. math::
   :name: eq:ther_cond

   \mathbfcal{K}(T) = \int_{\Omega} \nabla\mathbfcal{N}^T.\lambda(T).\nabla\mathbfcal{N} d\Omega + \int_{\Gamma_c} \mathbfcal{N}^T h(T) \mathbfcal{N} d\Gamma_c + \int_{\Gamma_r} \mathbfcal{N}^T \varepsilon\sigma \tilde{T}^3 \mathbfcal{N} d\Gamma_r

:math:`Q` est le **vecteur des puissances thermiques** :

.. math::
   :name: eq:ther_second_membre

   Q = \int_{\Omega} \mathbfcal{N}^T q d\Omega + \int_{\Gamma_{\phi}} \mathbfcal{N}^T \phi_{\textrm{imp}} \mathbfcal{N} d\Gamma + \int_{\Gamma_c} \mathbfcal{N}^T hT_f d\Gamma_c + \int_{\Gamma_r} \mathbfcal{N}^T \varepsilon\sigma T_{\infty}^4 d\Gamma_r

Prise en compte des blocages/relations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

La prise en compte des blocages ou des relations en température est faite de manière similaire à la
:ref:`mécanique  <sec:meca_stat_cl_depi>`. Les conditions de températures imposées :eq:`eq:ther_cl_timp_1`
s'écrivent à l'aide d'une matrice de blocage :math:`\mathbfcal{A}` :

.. math::
   :name: eq:ther_cl_timp_2

   \mathbfcal{A}.T = T_{\textrm{imp}}

Cette égalité sera adjointe au système :eq:`eq:ther_ef_1` et résolue à l'aide de multiplicateurs de Lagrange.

Opérateurs de Cast3M associés
-----------------------------

Les termes des équations :eq:`eq:ther_ef_1` et :eq:`eq:ther_cl_timp_2` sont calculés à l'aide des opérateurs suivants :

- :math:`\mathbfcal{C}`      : `CAPA <http://www-cast3m.cea.fr/index.php?page=notices&notice=CAPA>`_
- :math:`\mathbfcal{K}`     : `COND <http://www-cast3m.cea.fr/index.php?page=notices&notice=COND>`_
- :math:`Q`     : `SOUR <http://www-cast3m.cea.fr/index.php?page=notices&notice=SOUR>`_ (puissance volumique :math:`q`),
  `FLUX <http://www-cast3m.cea.fr/index.php?page=notices&notice=FLUX>`_ (flux imposé :math:`\phi_{\textrm{imp}}`),
  `CONV <http://www-cast3m.cea.fr/index.php?page=notices&notice=CONV>`_ (convection)
- :math:`\mathbfcal{A}`     : `BLOQ <http://www-cast3m.cea.fr/index.php?page=notices&notice=BLOQ>`_ (blocages),
  `RELA <http://www-cast3m.cea.fr/index.php?page=notices&notice=RELA>`_ (relations)
- :math:`T_{\textrm{imp}}` : `DEPI <http://www-cast3m.cea.fr/index.php?page=notices&notice=DEPI>`_
- La résolution du problème :eq:`eq:ther_ef_1` nécessite la mise en oeuvre d'un schéma numérique d'intégration temporelle.
  Plusieurs méthodes sont proposées dans la procédure `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_ et
  décrites ci-après.
- Les termes de rayonnement présents au premier membre :eq:`eq:ther_cond` et second membre :eq:`eq:ther_second_membre` de l'équation
  sont calculés par la procédure `PAS_RAYO <http://www-cast3m.cea.fr/index.php?page=notices&notice=PAS_RAYO>`_