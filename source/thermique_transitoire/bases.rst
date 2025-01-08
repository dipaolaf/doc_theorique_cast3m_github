.. _sec:ther_trans_bases:

Équations de la thermique
=========================

Équation de la chaleur
----------------------

Nous rappelons ici brievement les équations locales de la thermique.

**L'équation de la chaleur**, dans le cas générique sur un domaine :math:`\Omega`, s'écrit :

.. math::
   :name: eq:ther_chaleur_1

   \frac{\partial H}{\partial t} + \vec{\nabla}.\vec{\phi} = q

avec :

- :math:`H` l'enthalpie volumique (en J.m\ :sup:`-3`) ;
- :math:`\vec{\phi}` la densité de flux thermique (en W.m\ :sup:`-2`) ;
- :math:`q` la puissance volumique, terme source (en W.m\ :sup:`-3`).
- :math:`t` le temps (en s)

**L'enthalpie volumique** :math:`H` peut s'écrire :

.. math::
   :name: eq:ther_enthalpie_1

   \frac{\partial H}{\partial t} = \frac{\partial H}{\partial T} \frac{\partial T}{\partial t} = \rho c_p \frac{\partial T}{\partial t}

avec :

- :math:`\rho` la masse volumique (en kg.m\ :sup:`-3`) ;
- :math:`c_p` la capacité thermique massique (en J.kg\ :sup:`-1`.K\ :sup:`-1`).

**Le flux thermique** :math:`\vec{\phi}` est relié au gradient de température par la *loi de Fourier* :

.. math::
   :name: eq:ther_fourier_1

   \vec{\phi}=-\lambda \vec{\nabla} T

avec :

- :math:`T` la température (en K) ;
- :math:`\lambda` la conductivité thermique (en W.m\ :sup:`-1`.K\ :sup:`-1`).

Dans le cas où il n'y a pas de changement de phase et où les caractéristiques ne dépendent pas de la température, l'équation de la chaleur devient :

.. math::
   :name: eq:ther_chaleur_2

   \rho c_p \frac{\partial T}{\partial t} - \vec{\nabla}.\left(\lambda \vec{\nabla}T\right) = q


Conditions aux limites
----------------------

Les *conditions aux limites* peuvent porter soit sur la température :math:`T` :

.. math::
   :name: eq:ther_cl_timp

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

- :math:`h` le coefficient d'échange (en W.m\ :sup:`-2`.K\ :sup:`-1`) ;
- :math:`T_f` la température du fluide en paroi (en K) ;
- :math:`T_{\infty}` la température à l'infini (en K) ;
- :math:`\varepsilon` l'émissivité de la surface ;
- :math:`\sigma` la constante de Stefan-Boltzmann (égale à en 5,67 10\ :sup:`-8` W.m\ :sup:`-2`.K\ :sup:`-4`).

Formulation faible
------------------

En multipliant chaque terme de l'équation :eq:`eq:ther_chaleur_1` par un champ de température virtuel :math:`\tau`
non nul, puis en intégrant par partie sur :math:`\Omega`, on obtient une formulation faible de l'équation de la chaleur :

.. math::
   :name: eq:ther_form_faib_1

   \int_{\Omega} \left(\frac{\partial H}{\partial T}\frac{\partial T}{\partial t}\right)\tau d\Omega - \int_{\Omega} \lambda \vec{\nabla}T.\vec{\nabla}\tau d\Omega + \int_{\Gamma} \left(\lambda \vec{\nabla}T\right).\vec{n}\tau d\Gamma

L'intégrale sur le bord :math:`\Gamma` peut se réduire aux bords portant les conditions aux limites de flux imposé :

.. math::
   :name: eq:ther_form_faib_2

   \int_{\Gamma} \left(\lambda \vec{\nabla}T\right).\vec{n}\tau d\Gamma = - \int_{\Gamma_{\phi}}\phi_{\textrm{imp}}\tau d\Gamma_{\phi} - \int_{\Gamma_c}h(T_f-T)\tau d\Gamma_c - \int_{\Gamma_r}\varepsilon\sigma(T_{\infty}^4-T^4)\tau d\Gamma_r

Le terme du rayonnement peut être ramené à un terme de convection en faisant l'approximation suivante :

.. math::

   T_{\infty}^4-T^4 = (T_{\infty}-T)(\tilde{T}^3 + \tilde{T}^2 T_{\infty} + \tilde{T} T_{\infty}^2 + T_{\infty}^3)

Formulation éléments finis de l'équation de la chaleur
------------------------------------------------------

La température est discrétisée sur la base des fonctions d'interpolation :math:`\mathcal{N}` du maillage :

.. math::

   T(x,t) = \sum_i T_i(t) \mathcal{N}_i(x)

:math:`T_i` étant la valeur de la température au point :math:`i` du maillage. En injectant cette discrétisation dans la
formulation faible :eq:`eq:ther_form_faib_1`, nous obtenons le système matriciel :

.. math::
   :name: eq:ther_ef_1

   \mathcal{C}(T)\dot{T} + \mathcal{K}(T)T = Q

:math:`\mathcal{C}` est la **matrice de capacité** :

.. math::
   :name: eq:ther_capa

   \mathcal{C}_{ij}(T) = \int_{\Omega} \left(\frac{\partial H}{\partial T}\frac{\partial T}{\partial t}\right) \mathcal{N}_i\mathcal{N}_j d\Omega

:math:`\mathcal{K}` est la **matrice de conductivité** :

.. math::
   :name: eq:ther_cond

   \mathcal{K}_{ij}(T) = \int_{\Omega} \nabla\mathcal{N}_i . \left( \lambda(T) \nabla\mathcal{N}_j \right) d\Omega + \int_{\Gamma_c} h(T) \mathcal{N}_i \mathcal{N}_j d\Gamma_c + \int_{\Gamma_r} \varepsilon\sigma \tilde{T}^3 \mathcal{N}_i \mathcal{N}_j d\Gamma_r

:math:`Q` est le **vecteur des puissances thermiques** :

.. math::
   :name: eq:ther_second_membre

   Q_i = \int_{\Omega} q \mathcal{N}_i d\Omega + \int_{\Gamma_{\phi}} \phi_{\textrm{imp}} \mathcal{N}_i d\Gamma + \int_{\Gamma_c} hT_f \mathcal{N}_i d\Gamma_c + \int_{\Gamma_r} \varepsilon\sigma T_{\infty}^4 \mathcal{N}_i d\Gamma_r

Opérateurs de Cast3M associés
-----------------------------

Les termes de l'équation :eq:`eq:ther_ef_1` sont calculés à l'aide des opérateurs suivants :

-  :math:`\mathcal{C}` : `CAPA <http://www-cast3m.cea.fr/index.php?page=notices&notice=CAPA>`_
-  :math:`\mathcal{K}` : `COND <http://www-cast3m.cea.fr/index.php?page=notices&notice=COND>`_
-  :math:`Q` : `FLUX <http://www-cast3m.cea.fr/index.php?page=notices&notice=FLUX>`_ (flux imposé) et
   `CONV <http://www-cast3m.cea.fr/index.php?page=notices&notice=CONV>`_ (convection)
-  La résolution du problème :eq:`eq:ther_ef_1` nécessite la mise en oeuvre d'un schéma numérique d'intégration temporelle.
   Plusieurs méthodes sont proposées dans la procédure `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_
-  Les termes de rayonnement présents au premier membre :eq:`eq:ther_cond` et second membre :eq:`eq:ther_second_membre` de l'équation
   sont calculés par la procédure `PAS_RAYO <http://www-cast3m.cea.fr/index.php?page=notices&notice=PAS_RAYO>`_