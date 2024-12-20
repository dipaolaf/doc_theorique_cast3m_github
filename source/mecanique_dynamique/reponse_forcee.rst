.. _sec:meca_dyn_reponse_forcee:

Analyses spectrales du système linéaire forcé
=============================================

Équations du système linéaire forcé
-----------------------------------

On considère le système linéaire, amorti et excité par une force extérieure.

.. math::
   :label: eq_force1
   
   \mathcal{M} \ddot{u}(t) + \mathcal{C} \dot{u}(t) + \mathcal{K} u(t)
   &=  \mathcal{F}^\text{ext}(t) \\
   u(t=0)       &= u_0        \\
   \dot{u}(t=0) &= \dot{u}_0
   
.. Les conditions aux limites et initiales restent inchangées.

Dans la plupart des cas, le chargement extérieur peut se mettre sous la forme
séparant sa dépendance spatiale et temporelle :

.. math::
   :label: eq_force2
   
   \mathcal{F}^\text{ext}(x,t) = \mathcal{F}_0(x) \, f(t)

où :math:`f(t)` est une fonction scalaire du temps
et :math:`\mathcal{F}_0(x)` un vecteur éléments finis constant.


Réponse dans le cas général
---------------------------

Écriture du problème dans le domaine de Laplace
"""""""""""""""""""""""""""""""""""""""""""""""

Lorsque l'excitation a une durée finie dans le temps
(comme un créneau ou une impulsion)
ou atteint une valeur constante au bout d'un temps fini,
la réponse du système se compose d'une phase *transitoire*,
suivie d'un mouvement libre ou forcé, généralement amorti,
qui tend in fine vers un régime *stationnaire*.

Cette réponse générale
peut être obtenue par *tranformation de Laplace* du système.
On rappelle que cette tranformée se définit par :

.. math::
   :label: eq_laplace1
   
   \tilde{X}(s) \equiv \int_0^{\infty} X(t) \operatorname{e}^{-st} dt

Elle permet de transformer l'équation différentielle :eq:`eq_force1`
en un produit dans le domaine de Laplace
entre la *fonction de transfert* du système mécanique
et la tranformée de Laplace de l'excitation.

.. math::
   :label: eq_laplace2
   
   \tilde{u}(s) = \tilde{\mathcal{H}}(s) \, \tilde{\mathcal{F}}(s)

où apparaît la fonction de transfert et le second membre transformé :

.. math::
   :label: eq_laplace3
   
   \tilde{H}(s) 
   &= \left[ s^2 \mathcal{M}  + s \mathcal{C} + \mathcal{K} \right]^{-1} \\
   \tilde{\mathcal{F}}(w) 
   &= \tilde{\mathcal{F}}^\text{ext}(w)
   + \mathcal{M} \dot{u}_0
   + s \mathcal{M} {u}_0

La transformée de Laplace inverse permet ensuite d'obtenir la solution temporelle
(ou loi horaire).

.. La *fonction de Green* est la réponse à une impulsion unitaire
.. étant noté que la transformée de Laplace d'une impulsion est l'identité.
.. Elles permet de former la réponse à n'importe quelle excitation,
.. puisqu'on peut décomposer en impulsions élémentaires.


Fonction de transfert sur base modale
"""""""""""""""""""""""""""""""""""""

Il est aisée d'exprimer la fonction de transfert sur base modale
tant que l'amortissement respecte la décomposition de Basile
(aussi appelé amortissement de Rayleigh),
et on a alors :

.. math::
   :label: eq_laplace4
   
   \tilde{u}_j      
   &= \sum_{k} \tilde{H}(j,k,s) \tilde{\mathcal{F}}_k \\
   \text{avec} \quad
   \tilde{H}(j,k,s) 
   &= \sum_{i=1..m} \frac{\varphi_i(j) \varphi_i(k)}
                         {m_i (\omega_i^2 + s \xi_i \omega_i + s^2)}

         
        
Limites de la tranformation de Laplace
""""""""""""""""""""""""""""""""""""""

Bien que cette approche permette d'obtenir la réponse transitoire
d'un système linéaire à une sollicitation quelconque,
on préférera directement utiliser 
des :ref:`méthodes d'intégration temporelle <sec:meca_dyn_integration_temporelle>`
lorsque le transitoire est souhaité.
Une analyse spectrale en post-traitement des résultats temporels obtenus
peuvent apporter des éléments de compréhension et seront discutés
dans la section consacrée.



Réponse établie
---------------

Intérêt de la tranformation de Fourier pour les régimes établis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Lorsqu'une réponse établie (i.e stationnaire) est recherchée,
l'utilisation de la tranformation de Fourier
se trouve quant à elle compétitive.
Définissant cette tranformée et son inverse par :

.. math::
   :label: eq_fourier1
   
   \hat{X}(\omega) 
   &\equiv \int_{-\infty}^{\infty} X(t) \operatorname{e}^{-\boldsymbol{i} \omega t} dt \\
   X(t)
   &\equiv \frac{1}{2\pi}
   \int_{-\infty}^{\infty} \hat{X}(\omega) \operatorname{e}^{+\boldsymbol{i}\omega t } d\omega \\

on constate une grande analogie avec celle de Laplace,
les deux transformations partageant la plupart de leurs propriétés.
Contrairement à la première,
la tranformée de Fourier occulte la particularité de l'origine des temps,
la borne d'intégration inférieure étant :math:`-\infty`,
ce qui explique qu'elle soit utile à l'analyse de régimes établis
(aussi appelé stationnaires 
et définis par le comportement lorsque :math:`t \to \infty`).

Dans Cast3M, les opérateurs `TFR <www-cast3m.cea.fr/index.php?page=notices&notice=TFR>`_
et `TFRI <www-cast3m.cea.fr/index.php?page=notices&notice=TFRI>`_
permettent le calcul numérique des transformées de Fourier directe et inverse,
tandis que `DSPR <www-cast3m.cea.fr/index.php?page=notices&notice=DSPR>`_
fournit la densité spectrale de puissance d'un signal.


Réponse à un spectre d'excitation
"""""""""""""""""""""""""""""""""

Pour chaque degré de liberté, on a la relation sur les coefficients de Fourier :

.. math::
   :label: eq_fourier2
   
   \hat{u}(w) = \hat{\mathcal{H}}(w) \, \hat{\mathcal{F}}(w)

ainsi que sur les spectres :

.. math::
   :label: eq_fourier3
   
   S_{uu}(w)           &= |\mathcal{H}(w)|^2 \, S_{\mathcal{FF}}(w) \\
   S_{u\mathcal{F}}(w) &= \mathcal{H}(w)     \, S_{\mathcal{FF}}(w)

qui peut s'écrire entre n'importe quel degré de liberté j et k.
En particulier, lorsqu'il s'agit de mode, on a là encore :

.. math::
   :label: eq_fourier4
   
   \hat{H}(j,k,\omega) = \sum_{i=1..m} 
   \frac{\varphi_i(j) \varphi_i(k)}
        {m_i (\omega_i^2 - \omega^2 + 2 \boldsymbol{i} \xi_i \omega_i \omega)}

En pratique dans Cast3M,
connaissant les caractéristiques modales
et le spectre d'excitation sous la forme d'une évolution de la fréquence,
une simple multiplication permet de construire cette réponse.

Si l'on ne travaille pas sur base modale, 
l'équation :eq:`eq_fourier2` cache une système linéaire à résoudre
à chaque fréquence considérée,
puisque :

.. math::
   :label: eq_fourier5
   
   \hat{H}(\omega) 
   &= \left[ -\omega^2 \mathcal{M}  + \boldsymbol{i} \omega \mathcal{C} + \mathcal{K} \right]^{-1} \\

   
Exemples commentés avec un calcul spectral de régime forcé
----------------------------------------------------------

- Exemple de calcul d'un :ref:`rotor de Laval <ex:rotor_laval_poutre>`
