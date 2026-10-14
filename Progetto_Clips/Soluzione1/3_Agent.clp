(defmodule AGENT (import MAIN ?ALL) (import ENV ?ALL) (export ?ALL))

;contiene n riga, numero barche che sappiamo esserci (k-per-row), celle mancanti sulla riga, barche trovate tramite guess
(deftemplate row-val
  (slot row)
  (slot boat)
  (slot missing-cell)
  (slot found-boat)
)

;contiene n colonna, numero barche che sappiamo esserci (k-per-col), celle mancanti sulla colonna, barche trovate tramite guess
(deftemplate col-val
   (slot col)
   (slot boat)
   (slot missing-cell)
   (slot found-boat)
)

;contiene le coordinate della guess fatta a lato agent, insieme al contenuto della cella della barca guessata
(deftemplate agent-guess
  (slot x)
  (slot y)
  (slot content (allowed-values water left right middle top bot sub not-know middle-vertical middle-horizzontal))
)

;ci serve per dire in quali punti ipotiziamo esserci l'acqua (serve per restringere il campo dei guess)
(deftemplate water
    (slot x)
    (slot y))

(deftemplate boat-four-pieces
  (slot num)
)

;inizializza le row-val
(defrule start-row (declare (salience 100))
    (k-per-row (row ?r) (num ?num))
    (status (step ?s) (currently running))
    (test (eq ?s 0))
=>
    (assert (row-val (row ?r) (boat ?num) (missing-cell 10) (found-boat 0)))
)

;nel caso non siano presenti i valori sulla riga
(defrule start-row-nk (declare (salience 100))
    (not (k-per-row (row ?) (num ?)))
    (status (step ?s) (currently running))
    (test (eq ?s 0))
    =>
    (assert (row-val (row 0) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 1) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 2) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 3) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 4) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 5) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 6) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 7) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 8) (boat -1) (missing-cell 10) (found-boat 0)))
    (assert (row-val (row 9) (boat -1) (missing-cell 10) (found-boat 0)))
)

;inizializza le col-val
(defrule start-col (declare (salience 100))
    (k-per-col (col ?c) (num ?num))
    (status (step ?s) (currently running))
    (test (eq ?s 0))
=>
    (assert (col-val (col ?c) (boat ?num) (missing-cell 10) (found-boat 0)))
)

;nel caso non siano presenti i valori sulla colonna
(defrule start-col-nk (declare (salience 100))
    (not (k-per-col (col ?) (num ?)))
    (status (step ?s) (currently running))
    (test (eq ?s 0))
    =>
      (assert (col-val (col 0) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 1) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 2) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 3) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 4) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 5) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 6) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 7) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 8) (boat -1) (missing-cell 10) (found-boat 0)))
      (assert (col-val (col 9) (boat -1) (missing-cell 10) (found-boat 0))) 
)

(defrule start-boat-4-pieces (declare (salience 100))
  (status (step ?s) (currently running))
  (test (eq ?s 0))

  => 
    (assert (boat-four-pieces (num 1)))
)

(defrule go-on-main  (declare (salience 200))
  ?f1<-	(status (step ?s))
  (exec (step ?s))

=>
  (pop-focus)
)

(defrule go-on-water  (declare (salience -300))
   (status (step ?s) (currently running))
 =>
    (focus AGENT_W)
)