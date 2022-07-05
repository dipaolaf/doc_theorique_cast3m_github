.. _ex_vibrations_cloche:

Modélisation des vibrations d'une cloche : calcul des modes propres et réponse à un choc
----------------------------------------------------------------------------------------

Descriptif
""""""""""

Une cloche est étudiée à l'aide d'éléments massif quadratique.

.. admonition:: Extrait du script Cast3M : Données, maillage et modélisation
   :class: dropdown, note

   .. literalinclude:: ./vibrations_cloche.dgibi
      :language: gibiane
      :lines: 1-81
      :linenos:

      
Calcul des modes réels
""""""""""""""""""""""

On calcule les 30 premiers modes propres réels de la structure,
ce qui permet de couvrir la plage 0 - 4000 Hz.

.. admonition:: Extrait du script Cast3M : Calcul des modes réels
   :class: dropdown, note

   .. literalinclude:: ./vibrations_cloche.dgibi
      :language: gibiane
      :lines: 82-118
      :lineno-start: 81

.. figure:: ./vibrations_cloche-MODES.png
   :width: 600px
   :align: center
   
   Quelques exemple de déformées modales :math:`\varphi` en vue de face et de dessus
   

Calcul de la réponse à un choc par intégration temporelle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

On simule un choc par une force de courte durée (0.1 ms).
Deux intégrations temporelles sont menées avec le même pas de temps (:math:`\Delta t = 10` µs)
et comparées :

- avec la procédure DYNAMIC, en utilisant le schéma de l'accélération moyenne et sur base éléments finis.
- avec l'opérateur DYNE, en utilisant le schéma des différences centrées et sur base modale.

On observe des résultats très proches,
mais une bien meilleur efficacité en utilisant DYNE,
due à l'utilisation de la base réduite (diminution du nombre de ddl)
et au travail en lagage compilé (fortran pour un opérateur) 
plutôt qu'interprété (gibiane pour une procédure).

.. admonition:: Extrait du script Cast3M : Calcul de la réponse au balourd
   :class: dropdown, note

   .. literalinclude:: ./vibrations_cloche.dgibi
      :language: gibiane
      :lines: 119-320
      :lineno-start: 119

.. figure:: ./vibrations_cloche-CHOC.png
   :height: 280px
   :align: center
   
   Evolution temporelle (à gauche) et densité spectrale de puissance (à droite)
   du déplacement en un point en bas de la cloche
   pour les intégrations temporelles par DYNAMIC et DYNE.



Fichiers à télécharger
""""""""""""""""""""""

- `Jeu de données Cast3M <../.././vibrations_cloche.dgibi>`_
- `Fichier graphique résultat <../.././vibrations_cloche.pdf>`_
