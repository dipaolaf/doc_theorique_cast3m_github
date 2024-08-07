.. _sec:meca_dyn_modes:

Calculs modaux
==============

Calcul des modes propres réels
------------------------------

Les modes propres apportent une grande compréhension physique du système considéré.
Pour les obtenir, on considère le système conservatif, sans non-linéarité, ni chargement extérieur :

.. math::
   :label: eq_vibr1

   \mathcal{M} \ddot{u}(t) + \mathcal{K} u(t) = 0

Cette équation se résout en injectant dans l'équation précédente :

.. .. math::
..    :label: eq_vibr2
.. 
..    \vec{u}(x,t) &= \vec{\varphi}(x) \operatorname{e}^{\boldsymbol{i} \omega t}  \\
..    u(t)         &= \varphi \operatorname{e}^{\boldsymbol{i} \omega t}

.. math::
   :label: eq_vibr2

   u(t)         = \operatorname{Re} \left(
   \varphi \operatorname{e}^{\boldsymbol{i} \omega t}
   \right)

ce qui amène au problème aux valeurs propres :

.. math::
   :label: eq_vibr3
   
   \left[ \mathcal{K} - \omega^2 \mathcal{M} \right] \varphi = 0

où l'on a omis par les conditions aux limites évoquées précédemment.

Ce type de système est résolu en pratique dans Cast3M par l'opérateur
`VIBR <http://www-cast3m.cea.fr/index.php?page=notices&notice=VIBR>`_.
Ce dernier fournit les modes :math:`(\varphi_i,f_i)`
où :math:`i=1..m`,
la déformée modale est normalisée pour vérifier 
:math:`\max \left( \varphi_i \right) = 1`
et la fréquence est donnée en Hertz : :math:`f_i = \omega_i / 2 \pi`.

On rappelle que la base modale vérifie notamment :

.. math::
   :label: eq_vibr4
   
   \varphi_i^T \mathcal{K} \varphi_j 
   &= \begin{cases} k_i & \text{si } \, i = j \\ 0 & \text{sinon} \end{cases}  \\
   \varphi_i^T \mathcal{M} \varphi_j 
   &= \begin{cases} m_i & \text{si } \, i = j \\ 0 & \text{sinon} \end{cases}  \\
   \omega_i
   &= \sqrt{\frac{k_i}{m_i}}

   
Plusieurs algorithmes de résolution de ce système aux valeurs propres
ont été implémentées au fil des années (mots-clefs de `VIBR <http://www-cast3m.cea.fr/index.php?page=notices&notice=VIBR>`_) :

* ``'IRAM'`` : *Implictly Restarted Arnoldi Method*. 
  Basé sur la bibliothèque Arpack, il s'avère rapide et robuste
  mais ne dispose pas de vérification sur la complétude du spectre à ce jour.
  
* ``'SIMU'`` : *Lanczos*.
  Ré-écrit dans les années 2010 avec des re-démarrages explicites,
  il est généralement aussi rapide que le précédent.

* ``'PROC'`` : *Puissance inverse ou itérations sur sous-espace*.
  Il s'agit probablement de l'algorithme le plus robuste,
  mais peut s'avérer lent lorsque la taille du problème augmente.
  
* ``'INTE'`` : *Bisection emboitée*.  
  Algorithme le plus ancien, basé sur une recherche préalable des zéros
  du déterminant, il peut aussi être très lent 
  car nécessitant un grand nombre de factorisations de matrice.
  
  
Synthèse modale
---------------

On dispose ainsi d'une nouvelle *base orthonormée*
:math:`[\varphi] = [ ... \varphi_i ... ]`
pour les produits scalaires basés sur :math:`\mathcal{M}`
et :math:`\mathcal{K}`
avec toutes les bonnes propriétés mathématiques habituelles.

Généralement, seuls les premiers membres (les modes basses fréquences)
contribuent de manière non négligeable à la solution vibratoire
et on approxime :

.. math::
   :label: eq_reco1
   
    u(x,t) &\simeq \sum_{i=1..m}^{} \varphi_i(x) q_i (t)  \\
    u(t)   &\simeq \left[ \varphi \right] \cdot q(t)
  
On a ainsi tout intérêt à *projeter* le problème de départ 
sur cette base tronquée à l'ordre :math:`m` :

.. math::
   :label: eq_pjba1

   {M} \ddot{q}(t) + {C} \dot{q}(t) + {K} q(t)
   =  {F}^\text{ext}(t) + {F}^\text{nl}(u,\dot{u})

où les opérations de projection des matrices et vecteurs
sont réalisées par l'opérateur `PJBA <http://www-cast3m.cea.fr/index.php?page=notices&notice=PJBA>`_ :

.. math::
   :label: eq_pjba2
   
   M &= [\varphi]^T \cdot \mathcal{M} \cdot [\varphi] = \operatorname{diag}(m_i) \\
   K &= [\varphi]^T \cdot \mathcal{K} \cdot [\varphi] = \operatorname{diag}(k_i) \\
   C &= [\varphi]^T \cdot \mathcal{C} \cdot [\varphi] \\
   F &= [\varphi]^T \cdot \mathcal{F}

Très souvent, l'amortissement est mal connu
et on se limite à un amortissement modal (sans couplage entre mode) :
:math:`{C} = \operatorname{diag}(c_i) = 2 m_i \omega_i \xi_i`.

On parvient à cette forme :

- en identifiant (expérimentalement) directement les amortissements modaux
  :math:`\xi_i`,
  
- ou en utilisant un amortissement *de Rayleigh* :
  :math:`\mathcal{C} = a \mathcal{M} + b \mathcal{K}`
  qui conduit à :
  :math:`\xi_i = \frac{a}{2 \omega_i} + \frac{b \omega_i}{2}`
  
Ainsi, les termes de gauche de l'équation de la dynamique 
constitue un système découplé :

.. math::
   :label: eq_dyn_modal
   
   m_i \ddot{q}_i(t) + c_i \dot{q}_i(t) + k_i q_i(t) 
   &= f_i(t) \\
   \ddot{q}_i(t) + 2 \omega_i \xi_i \dot{q}_i(t) + \omega_i^2 q_i(t) 
   &= \frac{1}{m_i} f_i(t) 

   
L'opération réciproque de *recombinaison modale*
est quant à elle réalisée par les opérateurs 
`RECO <http://www-cast3m.cea.fr/index.php?page=notices&notice=RECO>`_
et `EVOL 'RECO'
<http://www-cast3m.cea.fr/index.php?page=notices&notice=EVOL#En%20plusieurs%20POINTS%20a%20partir%20d'une%20RECOMBINAISON%20MODALE%20(DYNE,POD)6>`_.

  
Sous-structuration
------------------

L'utilisation de la base des modes propres réels permet de réduire efficacement
la taille du système avant, par exemple, la résolution du problème complexe
ou non-linéaire.
Cependant, ce choix d'approximation peut parfois être mal adapté,
en présence d'une non-linéarité ou d'un amortissement localisé par exemple.

On peut alors avoir recours à des méthodes de sous-structuration.
Pour celle dite à *interfaces bloquée*, le principe consiste à :

1. Identifier des sous-structures élémentaires :math:`k = \{1 ...\}` avec des interfaces de cinématique minimale.

2. Calculer pour chaque sous-structure :math:`k` 
   une base de modes propres :math:`\varphi^\text{VIBR}_k`
   et de solutions statiques :math:`\varphi^\text{RESO}_k` 
   obtenues en imposant un déplacement unitaire pour chaque ddl de l'interface.

3. Assembler ces vecteurs afin de constituer un espace de projection pour le problème de départ.

Le cas-test `dyna14 <http://www-cast3m.cea.fr/index.php?page=exemples&exemple=dyna14>`_ constitue un exemple élémentaire d'utilisation.

*TODO : ajouter un autre cas d'utilisation plus intéressant.*


Calcul des modes propres complexes
----------------------------------

Si :math:`\mathcal{M}` ou :math:`\mathcal{K}` n'est pas symétrique,
ou que :math:`\mathcal{C}` n'est plus négligée,
le système aux valeurs propres devient non-Hermitien
et les modes propres deviennent complexes.

L'option ``'IRAM'`` de `VIBR <http://www-cast3m.cea.fr/index.php?page=notices&notice=VIBR>`_
permet de calculer directement les modes complexes sur les matrices éléments finis.

Cependant, pour des raisons d'efficacité,
on préfère souvent utiliser en pratique l'opérateur
`VIBC <http://www-cast3m.cea.fr/index.php?page=notices&notice=VIBC>`_
qui calcule les modes complexes sur le système projeté 
sur la base modale réelle calculée en négligeant les termes
responsables du caractère non-Hermitien du problème.
Cette approche suppose évidemment que ces termes soient suffisamment petits
pour que la base réelle permette une bonne représentation de la base complexe.
On résout donc :

.. math::
   :label: eq_vibc1
   
   \left[ {K} + \boldsymbol{i} \omega {C} - \omega^2 {M} \right]
   q = 0
   
avec :

.. math::
   :label: eq_vibc2
   
    \omega &= \operatorname{Re}(\omega_i) + \boldsymbol{i}\operatorname{Im}(\omega_i)    \\
    q_i    &= \operatorname{Re}(q_i)      + \boldsymbol{i}\operatorname{Im}(q_i)
   
et la déformée modale complexe recombinée :
:math:`\psi_i = [\varphi] \cdot q_i`.

Une déformée modale complexe signifie que la déformée n'est pas constante au cours d'un cycle.
Par exemple, pour des systèmes gyroscopique, le mode peut être
un mode de précession, dont la direction "tourne" au cours d'une période.

La partie réelle de la fréquence représente l'inverse de la période du cycle.
La partie imaginaire renseigne sur la *stabilité* du mode.


Exemples commentés de calcul de modes propres
---------------------------------------------

- Dans :ref:`cet exemple <ex:rotor_laval_poutre>`, sont calculés des modes réels et complexes d'un rotor.

- Dans :ref:`cet exemple <ex:vibrations_cloche>`, sont calculés les modes propres d'une cloche.
