# Recherche en Profondeur en LISP (IA01)

Implémentation en LISP d’un algorithme de recherche en profondeur (Depth-First Search) appliqué à un problème d’exploration d’espace d’états inspiré de l’univers Harry Potter.
Le programme simule la recherche et la destruction d’Horcruxes sur une carte en fonction des méthodes de destruction collectées.

## Objectifs

- Implémenter une recherche en profondeur limitée
- Manipuler un espace d’états dynamique
- Gérer inventaire, contraintes et exploration sans revisite
- Introduire une interaction multi-agents


## Fonctionnement
À chaque déplacement, l’agent :
- explore une nouvelle case,
- récupère une arme éventuelle,
- détruit un Horcruxe si la méthode adéquate est possédée,
- poursuit récursivement l’exploration.


## Contraintes :
- profondeur maximale : 7
- ordre d’exploration : Haut → Droite → Bas → Gauche


## Algorithmes implémentés
Recherche en profondeur (DFS)
Gestion des successeurs valides
Mise à jour dynamique de la carte
Gestion d’inventaire et conditions de destruction


## Extension : Mode Harry vs Voldemort
Une version étendue introduit un second agent :
Harry explore automatiquement (DFS)
Voldemort est contrôlé par l’utilisateur
fin de partie si les deux agents se rencontrent sous certaines conditions


## Structure
TP02_CAVELIUS_DERDAKI.cl   # Implémentation LISP

Rapport_TP02_IA01.pdf      # Analyse et conception


## Auteurs
CAVELIUS Walid
DERDAKI Tareq

Walid CAVELIUS
Tareq DERDAKI
