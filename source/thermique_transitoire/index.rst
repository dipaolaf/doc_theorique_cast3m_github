.. _sec:ther_trans:

Analyse thermique transitoire
*****************************

Ce document a pour objectif de décrire quelques éléments de théorie en analyse thermique
transitoire des structures ainsi que sur la méthode des éléments finis appliquée à la résolution
des problèmes thermiques dans Cast3M, notamment par la
`procédure de calcul PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_.

Par souci de simplicité, on assume certaines approximations dans la
présentation de ces éléments, notamment dans les développements
mathématiques associés. Pour une présentation rigoureuse et détaillée
des fondements théoriques du calcul par éléments finis en thermique, on
renvoie le lecteur aux nombreux ouvrages disponibles dans ce domaine.

Ce document s'appuie principalement sur la note [JEANVOINE-1995]_.

Après un rappel des bases théoriques, nous présenterons les différents schémas de résolution
mis en oeuvre dans `PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_ ainsi
qu'un exemple de validation.

.. toctree::
   :maxdepth: 1
   :caption: Sommaire

   bases
   change_phase
   integration_temporelle
   application
   references
