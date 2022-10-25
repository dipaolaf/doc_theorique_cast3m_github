.. _sec:mecanique_statique_reso:

Résolution de l'équilibre
=========================

Méthode
-------

  Dans le cas de comportements mécaniques non-linéaires, la résolution
  de l'équation d'équilibre (
  `[eq:statiqueLagrange1] <#eq:statiqueLagrange1>`__) est réalisée de
  façon itérative, suivant une méthode de point fixe, jusqu'à ce que le
  résidu soit suffisamment faible selon un critère
  donné (cf. §\ `1.5 <#sec:residu>`__).
  Les lois de comportement des matériaux étant généralement formulées en
  incrément ( :math:`\dot{\varepsilon}^p=\varphi(\dot{\sigma},p)`,
  etc.), il est plus pratique de formuler également l'équation
  d'équilibre en incrément.
  Pour cela, considérons des conditions initiales définies
  par (\ :math:`U_0`, :math:`\lambda_0`, :math:`\sigma_0`),
  éventuellement hors équilibre, et cherchons une
  solution (\ :math:`U_1,\lambda_1,\sigma_1`) qui équilibre le
  chargement défini par les efforts et déplacements imposés
  :math:`F^S_1`, :math:`F^V_1` et :math:`d_1`. Le passage de l'indice
  << 0 >> à l'indice << 1 >> représente un pas de calcul.

Incréments de déplacement
-------------------------

On décompose le champ de déplacement de la façon suivante :

.. math::

   U_1^i = U_0 + \Delta U_1^i \quad \textrm{et}
     \quad \Delta U_1^{i+1} = \Delta U_1^i + \delta \Delta U_1^{i+1} ,

avec :

-  :math:`U_0` : le déplacement en début de pas ;

-  :math:`U_1^i` : le déplacement courant ;

-  :math:`\Delta U_1^i` : l'incrément courant de déplacement ;

-  :math:`\delta \Delta U_1^{i+1}` : la correction de l'incrément
     courant de déplacement.

On montre facilement que :

.. math::

   U_1^{i+1} = U_1^i + \delta \Delta U_1^{i+1} .
   \label{eq:uddU}

Formulation incrémentale des conditions sur les déplacements
------------------------------------------------------------

  La formulation de conditions sur les déplacements :

  .. math:: A.U_1^{i+1} = d_1 ,

  s'écrit aussi de façon incrémentale :

  .. math::

     A. \delta \Delta U_1^{i+1} = d_1 - A.U_1^i ,
     \label{eq:residud}

  le membre de droite représentant un résidu sur le déplacement imposé.

Formulation incrémentale de l'équilibre
---------------------------------------

Après :math:`i` itérations, on cherche un champ
solution (\ :math:`U_1^{i+1},\lambda_1^{i+1},\sigma_1^{i+1}`) qui
satisfait l'équation
d'équilibre (\ `[eq:statiqueLagrange1] <#eq:statiqueLagrange1>`__) :

.. math:: K^{e}.U_1^{i+1} + A^T.\lambda_1^{i+1} = F^S_1 + F^V_1 - B.\sigma_1^{nl,i} ,

  :math:`\sigma_1^{nl,i}` étant << la partie non-linéaire >> des
  contraintes :math:`\sigma_1^{i}` obtenues à l'itération précédente.
  Injectons l'expression incrémentale (\ `[eq:uddU] <#eq:uddU>`__) de
  :math:`U_1^{i+1}` dans celle-ci :

  .. math::

     \begin{aligned}
     K^{e}.(U_1^i + \delta \Delta U_1^{i+1}) & = & F^S_1 + F^V_1 - A^T.\lambda_1^{i+1} - B.\sigma_1^{nl,i} , \\
       K^{e}.\delta \Delta U_1^{i+1} & = & F^S_1 + F^V_1 - \underbrace{A^T.\lambda_1^{i+1}}_{- F_1^R}
       - \underbrace{(K^{e}.U_1^i + B.\sigma_1^{nl,i})}_{B.\sigma_1^i\textrm{ d'apr\`es (\ref{eq:bsigma})}} .\end{aligned}

  Au membre de droite, on reconnait l'expression du résidu, d'où,
  finalement :

  .. math::

     K^{e}.\delta \Delta U_1^{i+1} = R^i_1 .
     \label{eq:minires1}

  Dans ces développements, nous n'avons pas précisé la dépendance des
  opérateurs :math:`K^{e}`, :math:`B` ou :math:`A` à la solution, ni
  détaillé ou commenté celle du chargement :math:`F^S_1`, :math:`F^V_1`
  ou :math:`F^R_1`.
  On peut assembler les équations (`[eq:residud] <#eq:residud>`__)
  et (\ `[eq:minires1] <#eq:minires1>`__) pour former le système
  suivant :

  .. math::

     \left(
       \begin{array}{cc}
       K^{e} & A^T \\
       A      & 0
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
       F_1^S + F_1^V - B.\sigma_1^i \\
       d_1 - A.U_1^i
       \end{array}
     \right).
     \label{eq:minires2}

En mettant l'équation d'équilibre sous cette forme, la ligne supérieure
du second membre n'est plus égale au résidu, qui doit alors être
post-traité. La décomposition du multiplicateur de Lagrange en
incréments permettrait de préserver l'expression du résidu au second
membre mais ce sont les forces de réaction qui devraient alors faire
l'objet d'un
post-traitement (\ :math:`F_1^{R,i+1}=F_1^{R,i}-A^T.\delta\lambda^{i+1}`).

Convergence
-----------

Comme évoqué au § \ `1.5 <#sec:residu>`__, la résolution itérative de
l'équilibre est menée jusqu'à ce que le résidu soit négligeable devant
une valeur de référence des efforts mis en jeu dans le problème traité
selon une norme donnée :

.. math:: |R| < \zeta\, F^{ref}.

Concernant la norme \ :math:`|.|`, il est classique d'utilisé la norme
infinie, à savoir le maximum en valeur absolue de toutes les composantes
du résidu. Concernant la valeur de référence \ :math:`F^{ref}`, on peut
utiliser la même norme appliquée aux efforts extérieurs. Enfin,
:math:`\zeta` est la précision, fixée par l'utilisateur.

Méthode de minimisation du résidu
---------------------------------

  La résolution itérative de
  l'équation (\ `[eq:minires2] <#eq:minires2>`__) est appelée méthode de
  << minimisation du résidu >>. La
  figure \ `[fig:algominires1] <#fig:algominires1>`__ présente un
  premier algorithme de résolution de l'équilibre basé sur cette
  méthode. Les notations adoptées ne précisent pas les indices de
  boucle.


**Algorithme de minimisation du résidu (1)**

:math:`(U_1,\lambda_1) = (U_0,\lambda_0)`
:math:`(\sigma_1, \varepsilon_1^{in},\upsilon_1) = (\sigma_0, \varepsilon_0^{in},\upsilon_0)`
:math:`F_1^R = -A^T.\lambda_1`
:math:`F^{ref} = | F_1^S + F_1^V + F_1^R|`
**tant que :math:`|R_1| \geq \zeta\, F^{ref}`**
:math:`\quad (\delta\Delta U_1, \lambda_1)` = **résoudre (\ **\ `[eq:minires2] <#eq:minires2>`__\ **)**
:math:`\quad U_1 = U_1 + \delta\Delta U_1`
:math:`\quad \varepsilon_1 = \mathcal{D}(U_1)`
:math:`\quad (\sigma_1,\varepsilon_1^{in}, \upsilon_1)` = **intégrer** :math:`\mathcal{C}\left(\varepsilon_1 , \varepsilon_1^{in}, \upsilon_1, p_1 \right)`
:math:`\quad F_1^R = -A^T.\lambda_1`
:math:`\quad R_1 = F_1^S + F_1^V + F_1^R - B.\sigma_1`
**fin**


  L'étude de la convergence de cet algorithme n'est pas l'objet de ce
  chapitre. On peut toutefois noter qu'à convergence, la
  solution \ :math:`(U_1,\lambda_1,\sigma_1)` obtenue satisfait
  l'équilibre des efforts sur le maillage :math:`\Omega^h` à
  :math:`\zeta` près, pour un chargement :math:`F_1^S`, :math:`F_1^V` et
  :math:`d_1`, des paramètres externes :math:`p_1`, une
  raideur \ :math:`K^{e}` et des opérateurs \ :math:`A` et :math:`B`
  fixés.
  L'opération d'intégration du comportement assure que le résultat
  :math:`(\sigma_1,\varepsilon_1^{in}, \upsilon_1)` satisafait les
  relations de comportement pour une déformation
  totale \ :math:`\varepsilon_1` mais, généralement, que de manière
  approchée. Dans ce cas, il est souhaitable que la précision adoptée
  pour intégrer le comportement soit meilleure que celle utilisée pour
  vérifier l'équilibre des efforts (\ :math:`\zeta`) afin d'assurer la
  stabilité de l'algorithme présenté.
  Par ailleurs, il faut également remarquer que, même si l'équilibre des
  efforts est atteint, rien ne garantit la stabilisation des
  déformations inélastiques ou des paramètres internes de la loi de
  comportement d'un itéré sur l'autre de l'algorithme, par exemple que :
  :math:`|\varepsilon_1^{in,i+1} - \varepsilon_1^{in,i}| < \zeta`. Dans
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
  :math:`F_1^V`, :math:`K^{e}`, :math:`A` et :math:`B`.
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
procédure PASAPAS.
