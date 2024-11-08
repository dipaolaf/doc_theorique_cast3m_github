.. _sec:opti_topo_intro:

Introduction à l'optimisation topologique
=========================================

Généralités
-----------

L'optimisation topologique consiste à chercher la **répartition optimale de la matière** dans une **pièce donnée**
soumise à des **chargements** et sous certaines **limitations**. L'inconnue de ce type de problème est la *topologie*,
c'est-à-dire *comment la matière est-elle répartie ?*

Dans un cadre mécanique, ce type de problème peut être formulé en : **trouver la distribution optimale de rigidité**
:math:`\mathbb{k}`, ce qui peut s'écrire :

.. math::
   :name: eq:opti_topo_1

   \min_{\mathbb{k}(m)} \quad & \psi(\mathbb{k})   & \\
   \textsf{tel que}     \quad & \chi_i(\mathbb{k}) &= 0 \\

Explicitons certains termes :

- Par **répartition optimale de la matière** on entend la distribution spatiale de rigidité :math:`\mathbb{k}(m)`
  en tout point :math:`m \in \Omega` qui minimise une fonction :math:`\psi` indicatrice du souhait de l'utilisateur.

- Par **pièce donnée** on entend que la recherche de la topologie se fait sur un domaine limité de l'espace :math:`\Omega`.

- Par **chargements** on entend que cette pièce subit des conditions aux limites, par exemple des déplacements
  imposés et des forces appliquées sur certaines zones.

- Par **limitations** on entend que l'optimisation se fait *sous contraintes*. C'est l'ensemble des fonctions
  :math:`\chi_i(\mathbb{k}) = 0`. En effet, afin d'éviter les solutions triviales, il est nécessaire d'imposer des
  contraintes. Par exemple, on peut chercher à minimiser le volume d'une pièce sous contrainte que celle-ci ne se
  déplace par trop (sans quoi la solution à volume nul sera optimale).

Le problème est illustré ci-dessous dans le cas d'une poutre en flexion 3 points.

.. figure:: figures/99_lines_img_1.png
   :name: fig:opti_topo_flexion
   :width: 15cm
   :align: center

   Problème d'optimisation topologique sur une poutre en flexion [SIGMUND-2001]_

Plusieurs choix de fonctions :math:`\psi` et :math:`\chi_i` sont alors possibles pour optimiser une structure,
comme par exemple :

- chercher la pièce la plus rigide possible, sans dépasser un certain volume
- chercher la pièce la plus légère possible, sans dépasser une certaine fréquence de résonnance
- chercher la pièce avec les contraintes mécaniques les plus faibles, sans dépasser un certain niveau de déplacement

Un choix très répendu de problème d'optimisation en mécanique des structures est de **minimiser la compliance**, c'est-à-dire
maximiser la raideur de la structure, **sous contrainte de volume**. En introduisant une discrétisation spatiale (maillage)
et une **variable de conception** discrète :math:`\textbf{x}`, le problème d'optimisation topologique peut être reformulé :

.. math::
   :name: eq:opti_topo_2

   \min_{\textbf{x}} \quad & \psi(\textbf{x}) = \textbf{F}^T.\textbf{U} = \textbf{U}^T.\mathbb{K}(\textbf{x}).\textbf{U} \\
   \textsf{tel que}  \quad & \chi(\textbf{x}) = V(\textbf{x}) - fV_0 = \sum_{e=1}^{N}x_eV_e - fV_0 = 0 \\
                           & \mathbb{K}(\textbf{x}).\textbf{U} =\textbf{F} \\
                           & x_e \in \{0;1\} \\

Détaillons les variables :

- :math:`\textbf{x}` est le vecteur des **variables de conception** :math:`x_e`, traduisant la présence de matière
  :math:`(x_e=1)` ou bien l'absence de matière :math:`(x_e=0)` dans l'élément :math:`e`
- :math:`\textbf{U}` et :math:`\textbf{F}` sont les vecteurs déplacements et forces globaux aux noeuds du maillage
- :math:`\mathbb{K}` est la matrice de rigidité globale
- :math:`V(\textbf{x})` est le volume de la topologie :math:`\textbf{x}` et :math:`V_e` le volume de
  l'élément :math:`e`
- :math:`f` la fraction volumique imposée
- :math:`V_0` le volume de domaine de conception :math:`\Omega`

Remarquons que la compliance :math:`\psi(\textbf{x}) = \textbf{F}^T.\textbf{U}` correspond aussi au travail des
forces extérieures.

.. _sec:opti_topo_simp:

La méthode SIMP
---------------

Dans ce document nous illustrerons brièvement la méthode SIMP, pour *Solid Isotropic Material with Penalization*
qui est la méthode d'optimisation topologique la plus répendue dans les codes inustriels et celle mise en oeuvre
dans Cast3M via la procédure TOPOPTIM. Le lecteur intéressé pourra consulter de nombreux ouvrages
sur le sujet dont :

- Les livres de référence [BENDSOE-1995]_ et [BENDSOE-SIGMUND-2004]_ qui détaillent rigouresement la théorie derrière l'optimisation
  topologique
- L'article pédagogique [SIGMUND-2001]_ qui présente une implémentation sur Matlab en 99 lignes d'un algorithme
  d'optimisation topologique. La procédure TOPOPTIM de Cast3M, ainsi que l'exemple utilisé dans ce document en
  sont grandement inspirés

Les principales idées de la méthode sont les suivantes :

- Introduire des **variables de conception continues** :math:`x_e \in [0;1]`, appelées aussi **densités**
- Pénaliser la rigidité :math:`\mathbb{K}` en fonction de :math:`\textbf{x}` par une loi puissance
  afin d'éviter la présence de densités intermédiaires. La matrice de rigidité de l'élément :math:`e`
  vaut ainsi :

.. math::
   \mathbb{k}_e=(x_e)^p\mathbb{k}_0

**Le problème d'optimisation de la compliance devient finalement :**

.. math::
   :name: eq:opti_topo_3

   \min_{\textbf{x}} \quad & \psi(\textbf{x}) = \textbf{U}^T.\mathbb{K}(\textbf{x}).\textbf{U} = \sum_{e=1}^N (x_e)^p \textbf{u}_e^T.\mathbb{k}_0.\textbf{u}_e \\
   \textsf{tel que}  \quad & \chi(\textbf{x}) = \sum_{e=1}^{N}x_eV_e - fV_0 = 0 \\
                           & \mathbb{K}(\textbf{x}).\textbf{U} =\textbf{F} \\
                           & 0 < x_{\textrm{min}} \le x_e \le 1 \\

avec :

- :math:`\textbf{u}_e` et :math:`\textbf{f}_e` les vecteurs déplacements et forces de l'élément :math:`e`
- :math:`\mathbb{k}_e` la matrice de rigidité de l'élément :math:`e`
- :math:`\mathbb{k}_0` la matrice de rigidité du matériau plein
- :math:`x_{\textrm{min}}` une densité minimale non nulle (pour éviter les singularités)
- :math:`p` le paramètre de pénalisation (en général :math:`p=3`)


.. _sec:opti_topo_oc:

Résolution du problème par Critère d'Optimalité
-----------------------------------------------

Un schéma de résolution heuristique et simple de ce type du problème :eq:`eq:opti_topo_3` est
proposé par [BENDSOE-1995]_ et consite à mettre à jour, de manière itérative, les densités
courantes :math:`\textbf{x}` vers une nouvelle valeur :math:`\textbf{x}^{\textrm{new}}` :

.. math::
   :name: eq:opti_topo_bendsoe

   x_e^{\textrm{new}} = \left\{
     \begin{array}{lll}
     x_e^-         & \textsf{si} & x_eB_e^{\eta} \le x_e^- \\
     x_eB_e^{\eta} & \textsf{si} & x_e^- < x_eB_e^{\eta} < x_e^+ \\
     x_e^+         & \textsf{si} & x_e^+ \le x_eB_e^{\eta} \\
     \end{array}
   \right.

avec :

- :math:`x_e^- = \max (x_{\textrm{min}},x_e-m)` une borne inférieure pour respecter
  l'inégalité :math:`x_{\textrm{min}} \le x_e^{\textrm{new}}`
- :math:`x_e^+ = \min (1,x_e+m)` la borne supérieure sur :math:`x_e` pour respecter
  l'inégalité :math:`x_e^{\textrm{new}} \le 1`
- :math:`\eta` est un coefficient d'amortissement (généralement :math:`\eta=0,5`)
- :math:`m` est une limite d'incrément de densité sur l'itération pour stabiliser la
  convergence

Le terme :math:`B_e` guidant la mise à jour de :math:`x_e` est obtenu par la condition d'optimalité :

.. math::
   :name: eq:opti_topo_optimalite

   B_e = \frac{-\dfrac{\partial \psi}{\partial x_e}}{\lambda \dfrac{\partial \chi}{\partial x_e}}

- :math:`\dfrac{\partial \psi}{\partial x_e}` est la **sensibilité** de la fonction objectif :math:`\psi`
- :math:`\dfrac{\partial \chi}{\partial x_e}` est la **sensibilité** de la fonction contrainte :math:`\chi`
- :math:`\lambda` est un **multiplicateur de Lagrange** pour satisfaire la contrainte de volume :math:`\chi`

En dérivant les expressions des fonctions, la sensibilité de la fonction objectif (compliance), en l'absence
de forces dépendantes de la densité, s'écrit :

.. math::
   :name: eq:opti_topo_sensibilite_1

   \frac{\partial \psi}{\partial x_e} = -p(x_e)^{p-1} \textbf{u}_e^T.\mathbb{k}_0.\textbf{u}_e

La sensibilité de la fonction contrainte (volume) s'écrit :

.. math::
   :name: eq:opti_topo_sensibilite_2

   \frac{\partial \chi}{\partial x_e} = V_e

La difficulté étant alors de trouver la valeur de :math:`\lambda` qui satisfait la contrainte.
Étant donné que la fonction contrainte :math:`\chi` a une décroissance monotone avec :math:`\lambda`,
on peut utiliser une **dichotomie** en initialisant des bornes inférieure :math:`\lambda^-` et supérieure :math:`\lambda^+`
puis en choisissant la valeur milieu de l'intervalle. Une évaluation de la fonction contrainte :math:`\chi`
est alors faite et le processus est répété dans le demi intervalle *ad hoc* :

.. _algo:opti_topo_dichotomie:

**Initialisation des bornes**

:math:`\lambda^- =0 \quad \lambda^+ =100 000`

**Tant que** \ :math:`(\lambda^+ - \lambda^-) > 0,0001` :

.. raw:: html

   <div style="margin-left:20px;width:300px;height:170px;">
.. math::

   \begin{array}{ll}
     \lambda                   & = (\lambda^- + \lambda^+)/2 \\
     \textbf{x}^{\textrm{new}} & = \textsf{actualiser } \textbf{x} \textsf{ selon (4)} \\
     \textsf{si } \chi(\textbf{x}) & > 0 & \\
       \quad \lambda^- & = \lambda \\
     \textsf{sinon} & \\
       \quad \lambda^+ & = \lambda \\
     \textsf{finsi} &\\
   \end{array} \\

.. raw:: html

   </div>

**Fin**

À l'issue de la dichotomie on obtient la valeur de :math:`\lambda` qui satisfait la contrainte
sur le volume ainsi que la nouvelle topologie :math:`\textbf{x}^{\textrm{new}}`.


.. _sec:opti_topo_filtre:

Filtrage de la sensibilité
--------------------------

Afin d'éviter l'effet de damier et diminuer la sensibilité des solutions au maillage, on applique une
procédure de filtrage (ou lissage) du champ de sensibilité. Sur chaque élément :math:`e` la sensibilité
de la compliance est remplacée par une valeur moyenne pondérée des sensibilités calculées sur les
éléments voisins :math:`f` dans un rayon :math:`r_{\textrm{min}}` :

.. math::
   :name: eq:opti_topo_filtrage

   \dfrac{\widehat{\partial \psi}}{\partial x_e} = \frac{1}{x_e}\dfrac{1}{\sum_{f=1}^{N_e}\hat{H}_f}\sum_{f=1}^{N_e}\hat{H}_fx_f\frac{\partial \psi}{\partial x_f}

L'opérateur de convolution :math:`\hat{H}_f` vaut :

.. math::

   \hat{H}_f = \left( 1 - \frac{\textrm{dist}(e,f)}{r_{\textrm{min}}} \right)^q V_f

et n'est définit que pour les :math:`N_e` éléments :math:`f` tels que :math:`\textrm{dist}(e,f) \le r_{\textrm{min}}`, avec :

- :math:`\textrm{dist}(e,f)` la distance entre les centres des éléments :math:`e` et :math:`f`
- :math:`V_f` le volume de l'élément `f` (ou bien une autre quantitié pour pondérer)
- :math:`r_{\textrm{min}}` le rayon du filtre, au dela duquel l'opérateur de convolution :math:`\hat{H}_f`
  est nul

Dans Cast3M, ce filtrage est réalisé grâce à l'opérateur `MFIL <http://www-cast3m.cea.fr/index.php?page=notices&notice=MFIL>`_.

Notons que dans l'article 99 lignes de [SIGMUND-2001]_ l'opérateur de filtrage utilisé correspond au cas où :math:`q=1` et
où tous les éléments ont un volume :math:`V_f=1`.


Illustration sur un cas mécanique
---------------------------------

Une mise en donnée de l'algorithme d'optimisation précédent est fournie en :ref:`annexe <ann:opti_topo_oc_dgibi>`
et disponible sur le `site Cast3M <http://www-cast3m.cea.fr/index.php?page=exemples&exemple=opti_topo_oc>`_.

Il s'agit d'optimiser la poutre en flexion présentée plus haut

.. figure:: figures/99_lines_img_1.png
   :width: 15cm
   :align: center

Pour l'optimisation, on choisit :

- une **fonction objectif** : la compliance :math:`\psi(\textbf{x}) = \textbf{U}^T.\mathbb{K}(\textbf{x}).\textbf{U}`
- une **contrainte sur le volume** : :math:`f=40\%` du domaine de conception
- les paramètres d'optimisation :math:`p=3`, :math:`\eta=0,5`, :math:`m=0,1` et :math:`x_{\textrm{min}}=0,001`.

On initialise la topologie ``x`` avec des densités homogènes :math:`x_e=f` afin de satisfaire la contrainte de volume.
Le volume cible est nommé ``vcib``.

On calcule la matrice de filtrage ``kfil``, intervenant dans l'équation :eq:`eq:opti_topo_filtrage` avec
l'opérateur `MFIL <http://www-cast3m.cea.fr/index.php?page=notices&notice=MFIL>`_.
Notons que pour cela, il est nécessaire de disposer du maillage ``mcg`` des centres de gravité du maillage ainsi que
du champ par points ``wg`` des volumes :math:`V_e` de chaque éléments, exprimé sur ces centres de gravité.
Le champ des volumes élémentaires ``vole`` est obtenu grâce à l'opérateur `INTG 'ELEM' <http://www-cast3m.cea.fr/index.php?page=notices&notice=INTG>`_
en intégrant un champ unitaire par élément.

.. admonition:: Initialisation : topologie initiale et matrice de filtrage

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 44-55
      :lineno-start: 44

On démarre ensuite une boucle d'optimisation limitée à 100 itérations.

On calcule alors ``rip``, la matrice de rigidité pénalisée :math:`\mathbb{K}(\textbf{x})` de la
topologie courante selon la loi puissance de la méthode SIMP. Le comportement étant isotrope,
le *module d'Young pénalisé* ``yop`` de chaque élément vaut :math:`E_e=(x_e)^pE_0` avec
:math:`E_0` le module d'Young du matériau.

On résoud ensuite le problème mécanique :math:`\mathbb{K}(\textbf{x}).\textbf{U} =\textbf{F}`.

.. admonition:: Pénalisation de la rigidité et résolution

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 57-65
      :lineno-start: 57

On peut calculer la valeur ``psi`` de la fonction objectif :math:`\psi(\textbf{x}) = \textbf{F}^T.\textbf{U}`
en remarquant que si celle-ci est égale au travail des forces extérieures, elle est donc aussi égale au travail des
efforts intérieurs et peut donc s'obtenir par :

.. math::

   \psi(\textbf{x}) = \int_{\Omega} \sigma(\textbf{x}):\varepsilon(\textbf{x}) dV

où :math:`\sigma` et :math:`\varepsilon` désignent les champs de contraintes et déformations ``sig`` ``eps``.
Le champ du double produit contracté :math:`\sigma:\varepsilon` est obtenu grâce à l'opérateur
`ENER <http://www-cast3m.cea.fr/index.php?page=notices&notice=ENER>`_ et son intégrale par
`INTG <http://www-cast3m.cea.fr/index.php?page=notices&notice=INTG>`_.

Le champ ``dpsi`` de sensibilité de la fonction objectif :eq:`eq:opti_topo_sensibilite_1` s'exprime alors en fonction
de la matrice de Hooke :math:`\mathcal{C}_0` du matériau plein :

.. math::

   \frac{\partial \psi}{\partial x_e} = -p(x_e)^{p-1} \varepsilon^T(x_e).\mathcal{C}_0.\varepsilon(x_e)

.. admonition:: Calcul de la fonction objectif et de sa sensibilités

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 69-77
      :lineno-start: 69

L'étape de filtrage de la sensibilité est réalisée en multipliant la matrice de filtrage ``kfil`` par le
champ par point ``xdpsi = x * dpsi`` représentant le produit :math:`x_f\dfrac{\partial \psi}{\partial x_f}` dans
l'équation :eq:`eq:opti_topo_filtrage`.

.. admonition:: Filtrage de la sensibilité

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 78-83
      :lineno-start: 78

La mise à jour de la topologie (passage du champ ``x`` à ``xnew``) suivant le schéma :eq:`eq:opti_topo_bendsoe`
est réalisée en suivant l':ref:`algorithme de dichotomie <algo:opti_topo_dichotomie>` pour la recherche du
multiplicateur de Lagrange ``lmid`` qui nécessite une nouvelle boucle (limitée à 50 itérations).

La limitation d'incrément :math:`m` et le recpect des bornes :math:`x_\textrm{min} \le x_e \le 1` sont réaliséespace
grâce aux opérateurs `BORN <http://www-cast3m.cea.fr/index.php?page=notices&notice=BORN>`_ et
`MASQ <http://www-cast3m.cea.fr/index.php?page=notices&notice=MASQ>`_, ce dernier produisant un champ
unitiare aux éléments respectant une inégalité et nul ailleur.

La vérification de la contrainte de volume est faite en calculant le volume ``vnew`` de chaque toplogie ``xnew``
et en le comparant au volume cible ``vcib``.

.. admonition:: Optimisation (critère d'optimalité)

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 84-106
      :lineno-start: 84

Un affichage bilan de l'itération est fait, puis un cirtère d'arrêt de la boucle d'optimisation
est proposé lorsque l'incrément maximal de densité est inférieur à 0,01

.. admonition:: Fin de boucle et critère d'arrêt

   .. literalinclude:: dgibi/opti_topo_oc.dgibi
      :language: gibiane
      :lines: 107-115
      :lineno-start: 107

Les résultats de cette optimisation sont présentés dans l'animation ci-dessous qui montre les topologies
(champs par éléments de densités) obtenues au cours des itérations. La topologie finale est atteinte
après 42 itérations.

.. figure:: figures/opti_topo_1.gif
   :name: fig:opti_topo_anim1
   :width: 20cm
   :align: center

   Animation des topologies au cours de l'optimisation (déformée x 1000)
