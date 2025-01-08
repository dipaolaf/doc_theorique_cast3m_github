.. _sec:meca_stat_reso:

Résolution de l'équilibre
=========================

Méthode
-------

Dans le cas de comportements mécaniques non-linéaires, la résolution
de l':ref:`équation d'équilibre <eq:meca_stat_statiqueLagrange1>` est réalisée de
façon itérative, suivant une méthode de point fixe, jusqu'à ce que le
:ref:`résidu <sec:meca_stat_residu>` soit suffisamment faible selon un critère donné.

Les lois de comportement des matériaux étant généralement formulées en
incrément (:math:`\dot{\varepsilon}^p=\varphi(\dot{\sigma},p)`,
etc.), il est plus pratique de formuler également l'équation
d'équilibre en incrément.

Pour cela, considérons des conditions initiales définies
par (\ :math:`U_0`, :math:`\lambda_0`, :math:`\sigma_0`),
éventuellement hors équilibre, et cherchons une
solution (\ :math:`U_1,\lambda_1,\sigma_1`) qui équilibre le
chargement défini par les efforts et déplacements imposés
:math:`F^S_1`, :math:`F^V_1` et :math:`d_1`. Le passage de l'indice 0 à
l'indice 1 représente un pas de calcul.

Incréments de déplacement
-------------------------

On décompose le champ de déplacement de la façon suivante :

.. math::

   U_1^i = U_0 + \Delta U_1^i \quad \textsf{et} \quad \Delta U_1^{i+1} = \Delta U_1^i + \delta \Delta U_1^{i+1}

avec :

-  :math:`U_0` : le déplacement en début de pas ;

-  :math:`U_1^i` : le déplacement courant ;

-  :math:`\Delta U_1^i` : l'incrément courant de déplacement ;

-  :math:`\delta \Delta U_1^{i+1}` : la correction de l'incrément courant de déplacement.

On montre facilement que :

.. math::
   :name: eq:meca_stat_uddU

   U_1^{i+1} = U_1^i + \delta \Delta U_1^{i+1}

Formulation incrémentale des conditions sur les déplacements
------------------------------------------------------------

La formulation de conditions sur les déplacements :

.. math:: \mathcal{A}.U_1^{i+1} = d_1

s'écrit aussi de façon incrémentale :

.. math::
   :name: eq:meca_stat_residud

   \mathcal{A}. \delta \Delta U_1^{i+1} = d_1 - \mathcal{A}.U_1^i

le membre de droite représentant un résidu sur le déplacement imposé.

Formulation incrémentale de l'équilibre
---------------------------------------

Après :math:`i` itérations, on cherche un champ
solution (\ :math:`U_1^{i+1},\lambda_1^{i+1},\sigma_1^{i+1}`) qui
satisfait l':ref:`équation d'équilibre <eq:meca_stat_statiqueLagrange1>` :

.. math:: \mathcal{K}^{e}.U_1^{i+1} + \mathcal{A}^T.\lambda_1^{i+1} = F^S_1 + F^V_1 - \mathcal{B}.\sigma_1^{\textrm{nl},i}

:math:`\sigma_1^{\textrm{nl},i}` étant *la partie non-linéaire* des contraintes :math:`\sigma_1^{i}`
obtenues à l'itération précédente. Injectons l'expression incrémentale :eq:`eq:meca_stat_uddU` de
:math:`U_1^{i+1}` dans celle-ci :

.. math::

   \begin{align*}
   \mathcal{K}^{e}.(U_1^i + \delta \Delta U_1^{i+1}) & = F^S_1 + F^V_1 - \mathcal{A}^T.\lambda_1^{i+1} - \mathcal{B}.\sigma_1^{\textrm{nl},i} \\
   \mathcal{K}^{e}.\delta \Delta U_1^{i+1}           & = F^S_1 + F^V_1 - \underbrace{\mathcal{A}^T.\lambda_1^{i+1}}_{- F_1^R}
     - \underbrace{(\mathcal{K}^{e}.U_1^i + \mathcal{B}.\sigma_1^{\textrm{nl},i})}_{\mathcal{B}.\sigma_1^i}
   \end{align*}

Le terme :math:`\mathcal{B}.\sigma_1^i` est identifié d'après :ref:`l'équation précédente <eq:meca_stat_bsigma>`. Au membre de droite, on
reconnait l'expression du résidu, d'où, finalement :

.. math::
   :name: eq:meca_stat_minires1

   \mathcal{K}^{e}.\delta \Delta U_1^{i+1} = R^i_1

Dans ces développements, nous n'avons pas précisé la dépendance des
opérateurs :math:`\mathcal{K}^{e}`, :math:`\mathcal{B}` ou :math:`\mathcal{A}` à la solution, ni
détaillé ou commenté celle du chargement :math:`F^S_1`, :math:`F^V_1`
ou :math:`F^R_1`.

On peut assembler les équations :eq:`eq:meca_stat_residud` et :eq:`eq:meca_stat_minires1` pour former le système suivant :

.. math::
   :name: eq:meca_stat_minires2

   \left(
     \begin{array}{cc}
     \mathcal{K}^{e} & \mathcal{A}^T \\
     \mathcal{A}      & 0
     \end{array}
   \right)
   \left(
     \begin{array}{c}
     \delta\Delta U_1^{i+1} \\
     \lambda_1^{i+1}
     \end{array}
   \right)
   =
   \left(
     \begin{array}{c}
     F_1^S + F_1^V - \mathcal{B}.\sigma_1^i \\
     d_1 - \mathcal{A}.U_1^i
     \end{array}
   \right)

En mettant l'équation d'équilibre sous cette forme, la ligne supérieure
du second membre n'est plus égale au résidu, qui doit alors être
post-traité. La décomposition du multiplicateur de Lagrange en
incréments permettrait de préserver l'expression du résidu au second
membre mais ce sont les forces de réaction qui devraient alors faire
l'objet d'un post-traitement :

.. math:: F_1^{R,i+1}=F_1^{R,i}-\mathcal{A}^T.\delta\lambda^{i+1}

Convergence
-----------

Comme évoqué au paragraphe sur le :ref:`résidu <sec:meca_stat_residu>`, la résolution itérative de
l'équilibre est menée jusqu'à ce que le résidu soit négligeable devant
une valeur de référence des efforts mis en jeu dans le problème traité
selon une norme donnée :

.. math:: |R| < \zeta\, F^{\textrm{ref}}

Concernant la norme \ :math:`|.|`, il est classique d'utiliser la norme
infinie, à savoir le maximum en valeur absolue de toutes les composantes
du résidu. Concernant la valeur de référence \ :math:`F^{\textrm{ref}}`, on peut
utiliser la même norme appliquée aux efforts extérieurs. Enfin,
:math:`\zeta` est la précision, fixée par l'utilisateur.


.. _algo:meca_stat_minires:

Méthode de minimisation du résidu
---------------------------------

La résolution itérative de l'équation :eq:`eq:meca_stat_minires2` est appelée méthode de
*minimisation du résidu*. On présente, ci-dessous, un premier algorithme de résolution de
l'équilibre basé sur cette méthode. Les notations adoptées ne précisent pas les indices de boucle.

Algorithme de minimisation du résidu
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Initialisation de la solution**

:math:`\begin{array}{lcl} (U_1,\lambda_1) & = & (U_0,\lambda_0) \\ (\sigma_1, \varepsilon_1^{\textrm{in}},\upsilon_1) & = & (\sigma_0, \varepsilon_0^{\textrm{in}},\upsilon_0) \\ F_1^R & = & -\mathcal{A}^T.\lambda_1 \\ F^{\textrm{ref}} & = & |F_1^S + F_1^V + F_1^R| \\ \end{array}`

**Tant que** \ :math:`|R_1| \geq \zeta F^{\textrm{ref}}` :

.. raw:: html

   <div style="margin-left:20px;width:300px;height:170px;">
.. math::

   \begin{array}{lcl}
     (\delta\Delta U_1, \lambda_1)                      & = & \textbf{resoudre (4)} \\
     U_1                                                & = & U_1 + \delta\Delta U_1 \\
     \varepsilon_1                                      & = & \mathcal{D}(U_1) \\
     (\sigma_1,\varepsilon_1^{\textrm{in}}, \upsilon_1) & = & \textbf{integrer } \mathcal{C}\left(\varepsilon_1 , \varepsilon_1^{\textrm{in}}, \upsilon_1, p_1 \right) \\
     F_1^R                                              & = & -\mathcal{A}^T.\lambda_1 \\
     R_1                                                & = & F_1^S + F_1^V + F_1^R - \mathcal{B}.\sigma_1\\
   \end{array}

.. raw:: html

   </div>

**Fin**

L'étude de la convergence de cet algorithme n'est pas l'objet de ce
chapitre. On peut toutefois noter qu'à convergence, la
solution \ :math:`(U_1,\lambda_1,\sigma_1)` obtenue satisfait
l'équilibre des efforts sur le maillage :math:`\Omega^h` à
:math:`\zeta` près, pour un chargement :math:`F_1^S`, :math:`F_1^V` et
:math:`d_1`, des paramètres externes :math:`p_1`, une
raideur \ :math:`\mathcal{K}^{e}` et des opérateurs \ :math:`\mathcal{A}` et :math:`\mathcal{B}`
fixés.

L'opération d'intégration du comportement assure que le résultat
:math:`(\sigma_1,\varepsilon_1^{\textrm{in}}, \upsilon_1)` satisafait les
relations de comportement pour une déformation totale
\ :math:`\varepsilon_1` mais, généralement, que de manière
approchée. Dans ce cas, il est souhaitable que la précision adoptée
pour intégrer le comportement soit meilleure que celle utilisée pour
vérifier l'équilibre des efforts (\ :math:`\zeta`) afin d'assurer la
stabilité de l'algorithme présenté.

Par ailleurs, il faut également remarquer que, même si l'équilibre des
efforts est atteint, rien ne garantit la stabilisation des
déformations inélastiques ou des paramètres internes de la loi de
comportement d'un itéré sur l'autre de l'algorithme, par exemple que :
:math:`|\varepsilon_1^{\textrm{in},i+1} - \varepsilon_1^{\textrm{in},i}| < \zeta`. Dans
le cas de calculs de fluage, où l'écoulement viscoplastique se produit
à effort constant, l'équilibre des efforts peut être atteint sans que
le matériau ait terminé de s'écouler. L'ajout d'un critère
supplémentaire, vérifiant la stabilisation de la déformation
inélastique, est alors indispensable pour garantir la convergence de
cet algorithme vers la solution au problème posé.

Enfin, lorsqu'on adopte un point vue Lagrangien, on identifie les
points du maillage à ceux du milieu matériel que l'on modélise. Ainsi,
la géométrie du maillage évolue au cours du déplacement, de même que
les grandeurs intégrées sur ce dernier, notamment :math:`F_1^S`,
:math:`F_1^V`, :math:`\mathcal{K}^{e}`, :math:`\mathcal{A}` et :math:`\mathcal{B}`.

L'équilibre statique devant être vérifié dans la configuration du
déplacement solution, il conviendrait donc de modifier cet algorithme
en mettant à jour les grandeurs associées au maillage au cours des
itérations pour garantir sa convergence vers une solution équilibée
dans la configuration déformée. Dans ce cas, on dit qu'on réalise le
calcul en grands déplacements. Lorsque l'on identifie les différentes
configurations du calcul à la configuration de départ, non déformée,
on dit qu'on réalise le calcul en petits déplacements.

.. _operateurs_associes_3:

Opérateurs de Cast3M associés
-----------------------------

La méthode de minimisation du résidu est notamment mis en œuvre dans la
procédure `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_.
