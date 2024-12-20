.. _sec:meca_dyn:

Analyse dynamique des structures
********************************

Cette documentation a pour but de faire le pont entre la théorie et l'application dans Cast3M des modélisations et calculs en dynamique des structures.

Ainsi, on admettra que sont maîtrisés :

* la méthode des éléments finis et en particulier, les éléments structuraux (plaques, coques, barres et poutres) ;
* l'utilisation élémentaire de Cast3M (cf. `formation débutant <http://www-cast3m.cea.fr/index.php?xml=formations>`_) ;
* les notions théoriques fondamentale en dynamique de structures.


Cette documentation est donc volontairement succinte, mais fait référence à d'autres supports plus approfondis
pour le lecteur désireux d'en savoir plus.

La littérature sur la méthode des éléments finis est très large et les ouvrages de [ZIENKIEWICZ-2005]_ ou [BATHE-2006]_ sont de bonnes références.

Concernant la dynamique des structures, là aussi, on compte bon nombre d'ouvrages excellents,
mais pour ne pas disperser le lecteur motivé, on conseillera ceux de [GERADIN-RIXEN-1993]_, [ARGYRIS-MLEJNEK-1991]_, [CLOUGH-PENZIEN-1991]_ 
ou les 3 volumes : [AXISA-2003]_ , [AXISA-2005]_ et [AXISA-2006]_.

Enfin, l'illustration de la dynamique de structures dans Cast3M a déjà été entreprise par [AXISA-1996]_ et [COMBESCURE-2006]_
et le lecteur pourra aussi s'y référer.

.. toctree::
   :maxdepth: 1
   :caption: Sommaire

   equation_dyn
   modes
   reponse_forcee
   integration_temporelle
   exemples
   references
