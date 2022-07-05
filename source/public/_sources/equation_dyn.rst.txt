.. _equation_dyn:

Equation de la dynamique
========================

Equation générale du mouvement
------------------------------

On considère ici un système mécanique 
sollicité ou qui évolue dans le temps suffisamment rapidement 
pour que ne soient pas négligés les *effets d'inertie*, ni les *effets visqueux*.
Il est donc régit par la forme faible stipulant que
:math:`\forall \vec{v}` cinématiquement admissible à 0,
on doit trouver :math:`\vec{u}` et :math:`\sigma` tels que soit vérifié
à chaque instant :

.. math::
   :label: eq_ppv1
   
   \int_{\Omega} \rho \ddot{\vec{u}}(t) \vec{v}(t) 
   + f^\text{visq}(\vec{u},\dot{\vec{u}}) \vec{v}(t)
   + \sigma(t) : \epsilon(\vec{v}(t))  d\Omega
   \\ \qquad 
   = \int_{d\Omega} f^\text{ext}(t)\vec{v}(t) 
   + f^\text{nl}(\vec{u},\dot{\vec{u}}) \vec{v}(t)  d\Gamma

La méthode des éléments finis amène à discrétiser
le déplacement (ainsi que la vitesse et l'accélération) sous la forme :

.. math::
   :label: eq_fem1
   
   \vec{u}(x,t) = 
   \begin{bmatrix} \vec{e}_1 \, \vec{e}_2 \, \vec{e}_3  \end{bmatrix}
   \,
   \begin{bmatrix} \mathcal{N}(x) \end{bmatrix}
   \, u(t)

La combinaisons des deux équations précédentes
conduit à l'équation d'équilibre dynamique discrétisée :

.. math::
   :label: eq_dyn1
   
   \mathcal{M} \ddot{u}(t) + \mathcal{F}^\text{visq}(\dot{u},u) + \mathcal{F}^\text{int}(\sigma)
   =  \mathcal{F}^\text{ext}(t) + \mathcal{F}^\text{nl}(u,\dot{u})

où l'on a distingué au second membre le *chargement extérieur*
et les efforts non-linéaires liées au *contact frottant*.

Les non-linéarités de type *comportement* ou *grands déplacements*
sont quant à elles complètement intégrées dans les efforts internes.
Leur traitement n'est pas propre à la dynamique
et nous n'en discuterons pas plus ici.


Equation du mouvement linéarisée pour les problèmes vibratoires
---------------------------------------------------------------

La plupart des problèmes dynamiques vibratoires se caractérise 
par de *petits* mouvements autour d'une position d'équilibre stationnaire.
On décompose ainsi la solution dynamique en la somme d'une contribution stationnaire
et vibratoire :

.. math::
   :label: eq_dyn2vib
  
   u^\text{tot}(t)  &=  u^0 + u(t) \\
   \sigma^\text{tot}(t)  &=  \sigma^0 + u(t) \\
   
Lorsque l'amplitude des vibrations est suffisamment petite
pour être considérée comme une *petite perturbation*,
on peut linéariser les termes liés aux efforts internes et visqueux :

.. math::
   :label: eq_dyn2

   \mathcal{M} \ddot{u}(t) + \mathcal{C} \dot{u}(t) + \mathcal{K} u(t)
   =  \mathcal{F}^\text{ext}(t) + \mathcal{F}^\text{nl}(u,\dot{u})

Si les contraintes de l'équilibre 
autour duquel le problème vibratoire est calculé
sont non négligeables,
alors la linéarisation des efforts internes
conduit à la prise en compte d'un terme de pré-contraintes
calculé avec l'opérateur
``KSIG`` (`notice de KSIG <http://www-cast3m.cea.fr/index.php?page=notices&notice=KSIG>`_)
en plus du terme lié à l'élasticité obtenu avec 
``RIGI`` 
(`notice de RIGI <http://www-cast3m.cea.fr/index.php?page=notices&notice=RIGI>`_) :
:math:`\mathcal{K} = \mathcal{K}^\text{RIGI} + \mathcal{K}^\text{KSIG}(\sigma^0)`.
Le cas-test `vibr13 <http://www-cast3m.cea.fr/index.php?page=exemples&exemple=vibr13>`_
est un exemple de calcul des modes propres d'une poutre précontrainte axialement.

De la même façon, la linéarisation d'une force de pression suiveuse
conduit à l'ajout des termes ``KSIG`` 
et ``KP`` 
(`notice de KP <http://www-cast3m.cea.fr/index.php?page=notices&notice=KP>`_) 
(voir l'exemple `vibr8 <http://www-cast3m.cea.fr/index.php?page=exemples&exemple=vibr8>`_).


Cette équation n'est pas complètement linéarisée
à cause de la présence du terme d'efforts non-linéaires au second membre
qu'on a volontairement conservé.
Mais c'est cette forme qui est intéressante pour la plupart des études vibratoires.


A cette équation, il convient d'ajouter les *conditions aux limites* 
qui s'expriment sous la forme d'une relation linéaire :

.. math::
   :label: eq_dyn3
   
   \mathcal{L} u(t) = u^\text{imp}(t)

et des *conditions initiales* généralement exprimée en (déplacement,vitesse)
à l'instant :math:`t=0` :

.. math::
   :label: eq_dyn4
   
   u(t=0)       &= u_0        \\
   \dot{u}(t=0) &= \dot{u}_0

On va voir par la suite qu'on ne cherche pas toujours 
à intégrer d'emblée cette équation différentielle.
En effet, une bonne connaissance du comportement dynamique du système
passe souvent par l'étude de ses modes,
sa réponse à une excitation harmonique ou aléatoire caractérisée par un spectre,
sa stabilité.


