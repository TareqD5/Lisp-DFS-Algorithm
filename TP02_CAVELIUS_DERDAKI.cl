(setq map '((1 12 2)(2 1 3)(3 2 4)(4 3 5)(5 4 8 6)(6 5 7)
            (7 8 6)(8 7 5)(12 13 1)(13 24 12)(15 22)(20 21 29)
            (21 22 20)(22 27 21 15)(24 25 13)(25 36 26 24)(26 25 27)
            (27 26 22)(29 32 20)(32 29)(36 25)))

(setq horcruxesDescription '(("Journal intime de Tom Jedusor" 
                                (methodeDestruction "Crochet de Basilic"))
                             ("Médaillon de Salazar Serpentard" 
                                (methodeDestruction "Epée de Gryffondor"))
                             ("Bague de Gaunt" 
                                (methodeDestruction "Epée de Gryffondor"))
                             ("Coupe de Helga Poufsouffle" 
                                (methodeDestruction "Crochet de Basilic"))
                             ("Nagini" 
                                (methodeDestruction "Epée de Gryffondor"))
                             ("Diadème de Rowena Serdaigle" 
                                (methodeDestruction "Feudeymon"))))


(setq horcruxesMap '((8 "Journal intime de Tom Jedusor")
                     (12 "Médaillon de Salazar Serpentard")
                     (15 "Bague de Gaunt")
                     (22 "Coupe de Helga Poufsouffle")
                     (26 "Nagini")
                     (29 "Diadème de Rowena Serdaigle")))

(setq armesMap '((3 "Crochet de Basilic")
                 (32 "Feudeymon")
                 (25 "Epée de Gryffondor")
                 (20 "Sortilège de la Mort")))   



;|------------------------------------------------------------------------------|
; Fonctions de Service


; 1 - Fonction successeurs-valides
; On sous-traite une partie du travail grâce à une fonction successeurs 



(defun successeurs (case carte)
  (cdr (assoc case carte)))
                    
(successeurs '1 map)                    



(defun successeurs-valides (case carte chemin_parcouru)
  (let 
      ((cases_suivantes_valides nil)(cases_suivantes (successeurs case carte)))
    (dolist (case_actuelle cases_suivantes cases_suivantes_valides)
      (if (not (member case_actuelle chemin_parcouru))
          (push case_actuelle cases_suivantes_valides)))))

(successeurs-valides '1 map '(3 4 5 12))



; 2 - Fonction methodeDestruction

; assoc non fonctionnel


(defun affichageMethodeDestruction (Horcruxe HorcruxesDescription)
  (dolist (horcruxe_actuelle HorcruxesDescription)
    (format t "~% ~s" (cadr(cadr horcruxe_actuelle)))
))

(defun methodeDestruction (Horcruxe HorcruxesDescription)
    (dolist (horcruxe_actuelle HorcruxesDescription)
      (if (equal Horcruxe (car horcruxe_actuelle))
          (return-from methodeDestruction (cadr(cadr horcruxe_actuelle)))
      )
    )
  )


(methodeDestruction "Nagini" horcruxesDescription)



; 3 - Fonction methodeDestruction



(defun hasBonneArme (horcruxe horcruxesDescription arsenal)
  (let ((methode (methodeDestruction horcruxe horcruxesDescription))
        (armePossedee))
    (dolist (arme arsenal)
       (if (equal arme methode)
           (setq armePossedee T)))
    armePossedee))

(hasBonneArme '"Nagini" horcruxesDescription '("Epée de Gryffondor" "Sortilège de la Mort"))
(hasBonneArme '"Nagini" horcruxesDescription '("Sortilège de la Mort"))



;|------------------------------------------------------------------------------|
; Recherche en profondeur pour la recherche de Harry Potter



(defun methodePresente (case ArmesMap)
  (cadr (assoc case ArmesMap)))

(methodePresente '3 armesMap)
(methodePresente '0 armesMap)




(defun supprimeArmeCarte(case ArmesMap)
  (setq ArmesMap (remove (assoc case ArmesMap) ArmesMap)))

(supprimeArmeCarte '3 armesMap)




(defun horcruxePresente (case HorcruxesMap)
  (cadr (assoc case HorcruxesMap)))

(horcruxePresente '22 horcruxesMap)
(horcruxePresente '0 horcruxesMap)




(defun supprimeHorcruxeCarte(case HorcruxesMap)
  (setq HorcruxesMap (remove (assoc case HorcruxesMap) HorcruxesMap)))

(supprimeHorcruxeCarte '15 HorcruxesMap)

  


(defun Recherche-Harry (case carte profondeur HorcruxesDescriptions cheminParcouru
                         HorcruxesMap HorcruxesDetruites ArmesMap ArmesPossedees)
  
  (format t "~% ~% Harry est à la case ~s" case)
  (push case cheminParcouru)
  (setq armePresente (methodePresente case ArmesMap))
  (if armePresente 
      (progn
        (format t "~% ~% Arme présente : ~s" armePresente)
        (push armePresente ArmesPossedees)
        (setq ArmesMap (supprimeArmeCarte case ArmesMap))
        (format t "~% Méthodes de Destruction récupérées :")
        (dolist (arme ArmesPossedees)
          (format t "~% ~s" arme))
        (format t "~%~% Passage à la case suivante...")
        )
    )
  (setq HorcruxePresente (horcruxePresente case HorcruxesMap))
  (if HorcruxePresente 
      (progn
        (format t "~%~% Horcruxes présente : ~s" HorcruxePresente)
        (if (hasBonneArme HorcruxePresente HorcruxesDescriptions ArmesPossedees)
            (progn
              (push HorcruxePresente HorcruxesDetruites) 
              (format t "~% Horcruxes détruites :")
              (dolist (horcruxe HorcruxesDetruites)
                (format t "~% ~s" horcruxe))
              (setq HorcruxesMap (supprimeHorcruxeCarte case HorcruxesMap))
              (format t "~%~% Passage à la case suivante...")
              )
          (progn
            (format t "~% La méthode de destruction nécessaire n'est pas possédée !")
            (format t "~% L'Horcruxe n'a pas été détruite et ne pourra plus l'être !")
            (setq HorcruxesMap (supprimeHorcruxeCarte case HorcruxesMap))
            (format t "~%~% Passage à la case suivante...")
            )
          )
        )
    )
  (if (< profondeur 7)
      (progn
        (setq cases_suivantes (nreverse(successeurs-valides case carte cheminParcouru)))
        (dolist (voisin cases_suivantes)
          (reverse (cons voisin (reverse cheminParcouru))))
        
        (dolist (voisin cases_suivantes)
          (setq data_parcours (Recherche-Harry voisin carte (+ profondeur 1) HorcruxesDescriptions cheminParcouru
                                                       HorcruxesMap HorcruxesDetruites ArmesMap ArmesPossedees))
          (setq HorcruxesDetruites (car data_parcours))
          (setq HorcruxesMap (cadr data_parcours))
          (setq ArmesMap (caddr data_parcours))
          (setq ArmesPossedees (cadddr data_parcours))
          (setq cheminParcouru (cadr(cdddr data_parcours))))))
  (list HorcruxesDetruites HorcruxesMap ArmesMap ArmesPossedees cheminParcouru))

  
        

(Recherche-Harry '1 map 0 horcruxesDescription nil horcruxesMap nil armesMap nil)
(Recherche-Harry '36 map 0 horcruxesDescription nil horcruxesMap nil armesMap nil)
 
  
;|------------------------------------------------------------------------------|
; Recherche en profondeur pour la recherche de Harry Potter ET Voldemort


(defun Recherche-Harry-Voldemort (caseHarry caseVoldemort carte profondeur HorcruxesDescriptions cheminParcouruHarry
                                  cheminParcouruVoldemort HorcruxesMapHarry HorcruxesMapVoldemort HorcruxesDetruitesHarry 
                                  HorcruxesDetruitesVoldemort ArmesMap ArmesPossedeesHarry
                                  ArmesPossedeesVoldemort)
  
  (when (and (equal caseHarry caseVoldemort)
               (member "Sortilège de la Mort" ArmesPossedeesVoldemort :test #'string=))
    (return-from Recherche-Harry-Voldemort (list "Harry Potter a été tué par Voldemort"))
    )
  
  (format t "~% ~% Harry est à la case ~s" caseHarry)
  (push caseHarry cheminParcouruHarry)
  (setq armePresente (methodePresente caseHarry ArmesMap))
  (if armePresente 
      (progn
        (format t "~% ~% Arme présente : ~s" armePresente)
        (push armePresente ArmesPossedeesHarry)
        (setq ArmesMap (supprimeArmeCarte caseHarry ArmesMap))
        (format t "~% Méthodes de Destruction récupérées :")
        (dolist (arme ArmesPossedeesHarry)
          (format t "~% ~s" arme))
        (format t "~%~% Passage à la case suivante...")
        )
    )
  
  (format t "~% ~% Voldemort est à la case ~s" caseVoldemort)
  (push caseVoldemort cheminParcouruVoldemort)
  (setq armePresente (methodePresente caseVoldemort ArmesMap))
  (if armePresente 
      (progn
        (format t "~% ~% Arme présente : ~s" armePresente)
        (push armePresente ArmesPossedeesVoldemort)
        (setq ArmesMap (supprimeArmeCarte caseVoldemort ArmesMap))
        (format t "~% Méthodes de Destruction récupérées :")
        (dolist (arme ArmesPossedeesVoldemort)
          (format t "~% ~s" arme))
        (format t "~%~% Passage à la case suivante...")
        )
    )
  
  (setq HorcruxePresente (horcruxePresente caseHarry HorcruxesMapHarry))
  (if HorcruxePresente 
      (progn
        (format t "~%~% Horcruxes présente sur la case Harry: ~s" HorcruxePresente)
        (if (hasBonneArme HorcruxePresente HorcruxesDescriptions ArmesPossedeesHarry)
            (progn
              (push HorcruxePresente HorcruxesDetruitesHarry) 
              (format t "~% Horcruxes détruites par Harry :")
              (dolist (horcruxe HorcruxesDetruitesHarry)
                (format t "~% ~s" horcruxe))
              (setq HorcruxesMapHarry (supprimeHorcruxeCarte caseHarry HorcruxesMapHarry))
              (format t "~%~% Passage à la case suivante...")
              )
          (progn
            (format t "~% La méthode de destruction nécessaire n'est pas possédée !")
            (format t "~% L'Horcruxe n'a pas été détruite et ne pourra plus l'être !")
            (setq HorcruxesMapHarry (supprimeHorcruxeCarte caseHarry HorcruxesMapHarry))
            (format t "~%~% Passage à la case suivante...")
            )
          )
        )
    )
  
  (setq HorcruxePresente (horcruxePresente caseVoldemort HorcruxesMapVoldemort))
  (if HorcruxePresente 
      (progn
        (format t "~%~% Horcruxes présente : ~s" HorcruxePresente)
        (if (hasBonneArme HorcruxePresente HorcruxesDescriptions ArmesPossedeesVoldemort)
            (progn
              (push HorcruxePresente HorcruxesDetruitesVoldemort) 
              (format t "~% Horcruxes détruites :")
              (dolist (horcruxe HorcruxesDetruitesVoldemort)
                (format t "~% ~s" horcruxe))
              (setq HorcruxesMapVoldemort (supprimeHorcruxeCarte caseVoldemort HorcruxesMapVoldemort))
              (format t "~%~% Passage à la case suivante...")
              )
          (progn
            (format t "~% La méthode de destruction nécessaire n'est pas possédée !")
            (format t "~% L'Horcruxe n'a pas été détruite et ne pourra plus l'être !")
            (setq HorcruxesMapVoldemort (supprimeHorcruxeCarte caseVoldemort HorcruxesMapVoldemort))
            (format t "~%~% Passage à la case suivante...")
            )
          )
        )
    )
  
  (if (< profondeur 7)
      (progn
        (setq cases_suivantes_harry (nreverse(successeurs-valides caseHarry carte cheminParcouruHarry)))
        (setq cases_suivantes_voldemort (assoc caseVoldemort carte))
        (dolist (voisin cases_suivantes_harry)
          (reverse (cons voisin (reverse cheminParcouruHarry))))
        
        (format t "~% Cases suivantes possibles pour Voldemort :")
        (dolist (voisin cases_suivantes_voldemort)
          (format t "~% ~s" voisin))
        (format t " ~% Entrer la case choisie: ")
        (setq inputCase (read))
        
        
        (dolist (voisin cases_suivantes_harry)
          (setq data_parcours (Recherche-Harry-Voldemort voisin inputCase carte (+ profondeur 1) HorcruxesDescriptions cheminParcouruHarry
                                                       cheminParcouruVoldemort HorcruxesMapHarry HorcruxesMapVoldemort HorcruxesDetruitesHarry 
                                               HorcruxesDetruitesVoldemort ArmesMap ArmesPossedeesHarry
                                               ArmesPossedeesVoldemort))
          (setq HorcruxesDetruitesHarry (car data_parcours))
          (setq HorcruxesDetruitesVoldemort (cadr data_parcours))
          (setq HorcruxesMapHarry (caddr data_parcours))
          (setq HorcruxesMapVoldemort (cadddr data_parcours))
          (setq ArmesMap (cadr(cdddr data_parcours)))
          (setq ArmesPossedeesHarry (caddr (cdddr data_parcours)))
          (setq ArmesPossedeesVoldemort (cadddr (cdddr data_parcours)))
          (setq cheminParcouruHarry (cadr(cdddr (cdddr data_parcours))))
          (setq cheminParcouruVoldemort (caddr (cdddr (cdddr data_parcours)))))))
  (list HorcruxesDetruitesHarry HorcruxesDetruitesVoldemort HorcruxesMapHarry HorcruxesMapVoldemort ArmesMap ArmesPossedeesHarry ArmesPossedeesVoldemort cheminParcouruHarry cheminParcouruVoldemort))

  
        

(Recherche-Harry-Voldemort '32 '20 map '0 horcruxesDescription nil nil horcruxesMapHarry horcruxesMapVoldemort nil nil armesMap nil nil)
















  
  

