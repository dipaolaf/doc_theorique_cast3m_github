.. _sec:meca_stat:

Analyse quasi statique des structures
*************************************

Ce document est une autre version du document sur la statique disponible sur le site
`Cast3M <http://www-cast3m.cea.fr/html/Documentation_Cast3M/mecanique.pdf>`_.

L'objectif est de rappeler aux utilisateurs quelques
éléments de théorie concernant la mécanique des milieux continus et la
méthode des éléments finis afin qu'ils aient une meilleure maitrise
des modélisations qu'ils réalisent avec le logiciel. Ce document
s'adresse ainsi à des utilisateurs quelque peu expérimentés, qui
possèdent de bonnes connaissances en mécanique et en calcul par
éléments finis.

Par souci de simplicité, on assume certaines approximations dans la
présentation de ces éléments, notamment dans les développements
mathématiques associés. Pour une présentation rigoureuse et détaillée
des fondements théoriques du calcul par éléments finis en mécanique
des structures, on renvoie le lecteur aux nombreux ouvrages
disponibles dans ce domaine.

Enfin, ce document ne propose pas un état de l'art exhaustif des
concepts et méthodes numériques utilisés, notamment dans la
`procédure de calcul PASAPAS <http://www-cast3m.cea.fr/index.php?page=notices&notice=PASAPAS>`_.
La raison en est simplement que cet état évolue continûment, au gré des
améliorations apportées au logiciel, et que la mise à jour de ce document
ne fait pas partie du processus de développement de Cast3M.

.. toctree::
   :maxdepth: 1
   :caption: Sommaire

   equilibre
   comportement
   cl_depi
   reso
   applications
   dgibi
