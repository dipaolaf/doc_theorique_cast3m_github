.. _sec:meca_dyn_integration_temporelle:

Analyse par intégration temporelle
==================================

Les schémas de Newmark
----------------------

Relations de récurrence
"""""""""""""""""""""""

Les relations de récurrence du schéma de Newmark sont rappelées :

.. math::
   
   q_{n+1} & =  q_{n} 
              + \Delta t{\dot q}_{n}  
              + \Delta t^2 \left( \frac{1}{2}-\beta \right) {\ddot q}_{n}
              + \Delta t^2 \beta {\ddot q}_{n+1} 
   \\
   {\dot q}_{n+1} & =  {\dot q}_{n} 
              + \Delta t(1 - \gamma) {\ddot q}_{n} 
              + \Delta t\gamma {\ddot q}_{n+1}
              
Appliquées à l'équilibre dynamique, elles permettent d'écrire le problème sous la forme :

.. math::

   [ M + \Delta t \gamma C + \Delta t^2 \beta K ] \ddot{q}_{n+1} 
   = F^\text{ext}_{n+1} + F^\text{nl}_{n+1}
   - K {q}_{n+1}^\text{pred} 
   - C {\dot q}_{n+1}^\text{pred} 

où l'on a définit les "prédicteurs" :

.. math::

   {q}_{n+1}^\text{pred}  & =  q_{n} 
              + \Delta t{\dot q}_{n}  
              + \Delta t^2 \left( \frac{1}{2}-\beta \right) {\ddot q}_{n}
   \\ 
   {\dot q}_{n+1}^\text{pred}  & =  {\dot q}_{n} 
              + \Delta t(1 - \gamma) {\ddot q}_{n} 

Propriétés
""""""""""

Les propriétés (notamment ordre et stabilité) 
des schémas de Newmark dépendent donc du choix des paramètres
:math:`\gamma` et :math:`\beta`.
En particulier, on montre qu'on a l'ordre 2 (et donc une bonne précision) pour :math:`\gamma=1/2`.

Le tableau suivant compare les limites de stabilité de quelques schémas.

.. table:: Stabilité de quelques schémas d'intégration temporelle
   :align: center

   +----------------+---------------------+--------------------------+-------------------------------------+
   | Schéma         | :math:`\gamma`      | :math:`\beta`            | :math:`\Delta t_{c} / \Delta t^{e}` |
   +================+=====================+==========================+=====================================+
   | Différence     | :math:`1/2`         | :math:`0`                | :math:`2`                           |
   | centrée        |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Fox and        | :math:`1/2`         | :math:`1/12`             | :math:`2.45`                        |
   | Goodwin        |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Accélération   | :math:`1/2`         | :math:`1/6`              | :math:`3.46`                        |
   | linéaire       |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Accélération   | :math:`1/2`         | :math:`1/4`              | :math:`\infty`                      |
   | moyenne        |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Accélération   | :math:`1/2+\alpha`  | :math:`1/4(1+\alpha)^2`  | :math:`\infty`                      |
   | moyenne        |                     |                          |                                     |
   | modifiée       |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Runge-Kutta 4  |                     |                          | :math:`2 \sqrt 2`                   |
   |                |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+
   | Fu-De          |                     |                          | :math:`2 \sqrt 2`                   |
   | Vogelaere      |                     |                          |                                     |
   +----------------+---------------------+--------------------------+-------------------------------------+

Cas des différences centrées
""""""""""""""""""""""""""""

La mise en oeuvre effective du schéma des différences centrées
est très simple :

Etant donné :math:`q_0` et :math:`\dot{q}_0`,
pour les pas de temps indicé :math:`n=1 ... N`, on réalise les étapes :

- Calcul explicite du déplacement :
  :math:`q_{n+1} = q_{n} + \Delta t {\dot q}_{n} + \frac{\Delta t^2}{2} {\ddot q}_{n}`
  
- Calcul de la vitesse au demi-pas : 
  :math:`{\dot q}_{n+1/2} = \frac{q_{n+1} - q_n}{\Delta t}`
  
- Résolution de :
  :math:`\left[ M + {\frac{\Delta t}{2} C} \right] \ddot{q}_{n+1} = F^\text{ext}_{n+1} + F^\text{nl}_{n+1} - K {q}_{n+1} - C {\dot q}_{n+1/2}`
  
- Calcul de la vitesse :
  :math:`{\dot q}_{n+1} \longleftarrow {\dot q}_{n+1/2} + \frac{\Delta t}{2}\ddot{q}_{n+1}`

Souvent les amortissements sont faibles,
et on néglige la matrice d'amortissement à gauche du signe égal.
Cela permet d'avoir un schéma *explicite*,
puisque l'état à l'instant :math:`n+1` est obtenu directement 
par de simples opérations algébriques sur les quantités à l'instant :math:`n`.

De plus, si la matrice de masse est diagonalisable,
la résolution devient une simple division du type :math:`\ddot{q}_{n+1} = F / M`,
ce qui explique l'attrait pour ce type de schéma.

La principale limitation concerne finalement le pas de temps,
lié à la discrétisation spatiale,
qui va restreindre le champ d'applications aux phénomènes rapides
(impact, explosion ...).

Ce type de schéma est celui utilisé par l'opérateur `DYNE <http://www-cast3m.cea.fr/index.php?page=notices&notice=DYNE>`_
dans Cast3M pour des problèmes vibratoires. Pour les applications en dynamique rapide,
il faut plutôt utiliser un code dédié comme Europlexus.


Cas de l'accélération moyenne
"""""""""""""""""""""""""""""

A contrario, le schéma de l'accélération moyenne n'a pas de pas de temps critique.
Il est cependant implicite, ce qui signifie qu'un système algébrique
(le plus souvent non-linéaire) doit être résolu à chaque pas de temps.

C'est notamment celui utilisé par les procédures
`PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_ ou
`DYNAMIC <http://www-cast3m.cea.fr/index.php?page=notices&notice=DYNAMIC>`_.

   
Analyse des résultats temporels
-------------------------------

La souplesse de Cast3M permet d'analyser les résultats de nombreuses
manières, plus ou moins automatisées.
On liste quelques post-traitements ci-après,
et on renvoie principalement vers la base des cas-tests très riche.

Évolutions temporelles
""""""""""""""""""""""

On peut choisir de tracer des évolutions temporelles du type :math:`q - t`
ou des portraits de phase :math:`q - \dot{q}`.
Ceci implique la création d'objet EVOLUTION en bouclant sur les pas de temps, ou en appelant
`EVOL 'RECO' <https://www-cast3m.cea.fr/index.php?page=notices&notice=EVOL#En%20plusieurs%20POINTS%20a%20partir%20d'une%20RECOMBINAISON%20MODALE%20(DYNE,POD)6>`_ dans le cas de l'utilisation `DYNE <http://www-cast3m.cea.fr/index.php?page=notices&notice=DYNE>`_.

Animations
""""""""""

Il est possible de créer une suite de DEFORMEE et d'en faire une sortie postscript
ou de sortir au format VTK des données (maillage, déplacement, etc.) 
afin de les post-traiter avec Paraview.

Analyse spectrale des résultats temporels
"""""""""""""""""""""""""""""""""""""""""

Les opérateurs `TFR <http://www-cast3m.cea.fr/index.php?page=notices&notice=TFR>`_ et
`DSPR <http://www-cast3m.cea.fr/index.php?page=notices&notice=DSPR>`_ permettent
de contruire les courbes de transformées de Fourier et densité spectrales de puissance.


Exemples commentés réalisant une intégration temporelle
-------------------------------------------------------

- Dans :ref:`cet exemple <ex:vibrations_cloche>`, est étudié l'impact d'une cloche avec
  `DYNAMIC <http://www-cast3m.cea.fr/index.php?page=notices&notice=DYNAMIC>`_ et
  `DYNE <http://www-cast3m.cea.fr/index.php?page=notices&notice=DYNE>`_.
