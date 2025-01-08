.. _sec:ther_trans_schemas:

Schémas numériques d'intégration temporelle
===========================================

Nous présentons ici les deux schémas numériques d'intégration temporelle disponibles
dans Cast3M pour résoudre les problèmes thermiques transitoires :eq:`eq:ther_ef_1`.
Ces schémas sont disponibles dans la procédures `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_
via le mot clef ``'PROCEDURE_THERMIQUE'``.

Dans tous les cas, l'idée est discrétiser dans le temps les champs de température et de les calculer à certains instants.
Nous décrirons ci-dessous les algorithmes de calcul de la température à la fin d'un pas de temps, en supposant connu les résultats
au début du pas de temps. On notera donc :

- :math:`t^n` et :math:`t^{n+1}`   : les instants au début et à la fin du pas
- :math:`\Delta t = t^{n+1} - t^n` : le pas de temps
- :math:`T^n` et :math:`T^{n+1}`   : les champ de température au début (connu) et à la fin du pas (inconnu) 

La :math:`\theta`-méthode
-------------------------
Ce schéma classique est mis en oeuvre dans la procédure `TRANSNON <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=TRANSNON>`_.
La discrétisation temporelle du problème :eq:`eq:ther_ef_1` est la suivante :




L'algorithme de Dupond
----------------------
Ce schéma est mis en oeuvre dans la procédure `DUPONT2 <https://www-cast3m.cea.fr/index.php?page=procedures&procedure=DUPONT2>`_
et est issu des travaux de [DUPONT-1974]_.

La discrétisation temporelle du problème :eq:`eq:ther_ef_1` est la suivante :

.. math::
   :name: eq:ther_dupont_1

   \frac{1}{\Delta t}\mathcal{C}^{\star}(T^{n+1}-T^n) + \mathcal{K}^{\star} \left[\left(\frac{1}{2}+a\right)T^{n+1} + \left(\frac{1}{2}-2a\right)T^n - aT^{n-1}\right] = Q^{\star}

- L'indice :math:`^{\star}` siginifie que les matrices et les vecteurs sont évalués :

  - à la température :math:`T^{\star} = (1-b)T^n + b(2T^n-T^{n-1})`
  - à l'instant :math:`t^{\star} = (1-b)t^n + bt^{n+1}`

- Le paramètre :math:`a` est le **coefficient de relaxation** :math:`0 \leq a \leq 1`
- Le paramètre :math:`b` est le **coefficient de sous relaxation** :math:`0 \leq b \leq 1`

Cette famille de schémas possède les propriétés suivantes :

- Non itératif.
- Non auto démarrant, en effet, la connaissance de :math:`T^0` et :math:`T^1` est nécessaire pour calculer :math:`T^2` (puis les
  températures à tous les instants de calcul suivants). On calculera donc la température au premier instant :math:`T^1` à l'aide
  d'un schéma à un pas de temps itératif, puis les suivantes avec le schéma de Dupont.
- Précision du second ordre en temps.
- Inconditionnellement stable.

