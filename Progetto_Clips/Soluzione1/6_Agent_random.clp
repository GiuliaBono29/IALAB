; RANDOMIZE ha il compito di scegliere dove piazzare le guess, basandosi sul numero di celle conosciute (definite tramite i template col-val)

(defmodule AGENT_R (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

(defrule make-fire-row (declare (salience 100))
  (status (step ?s)(currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?f 0))
  (test (> ?mc1 0))
  (test (>= ?b1 0))
  (test (>= (/ (- ?b1 ?fb1) ?mc1) 0.4)) 
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  
  =>
    (assert (exec (step ?s) (action fire) (x ?x) (y ?y)))
    (assert (back-to-agent))
  
)


(defrule make-fire-col (declare (salience 100))
  (status (step ?s)(currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?f 0))
  (test (> ?mc2 0))
  (test (>= ?b2 0))
  (test (>= (/ (- ?b2 ?fb2) ?mc2) 0.4))
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  
  =>
    (assert (exec (step ?s) (action fire) (x ?x) (y ?y)))

    (assert (back-to-agent))
  
)

(defrule make-guess-row
  (status (step ?s) (currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?g 0))
  (test (> ?mc1 0))
  (test (>= ?b1 0))
  (test (>= (/ (- ?b1 ?fb1) ?mc1) 0.4)) 
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))

  =>
  (assert (exec (step ?s) (action guess) (x ?x) (y ?y)))
  (assert(back-to-agent))
)

(defrule make-guess-col
  (status (step ?s) (currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?g 0))
  (test (> ?mc2 0))
  (test (>= ?b2 0))
  (test (>= (/ (- ?b2 ?fb2) ?mc2) 0.4)) 
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  =>
  (assert (exec (step ?s) (action guess) (x ?x) (y ?y)))
  (assert(back-to-agent))
)

(defrule make-fire-row-not-exists (declare (salience 100))
  (status (step ?s)(currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?f 0))
  (test (> ?mc1 0))
  (test (< ?b1 0)) 
  (test (>= (/ ?mc1 10) 0.4))
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))

  =>
    (assert (exec (step ?s) (action fire) (x ?x) (y ?y)))
    (assert (back-to-agent))     
)


(defrule make-fire-col-not-exists (declare (salience 100))
  (status (step ?s)(currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?f 0))
  (test (> ?mc2 0))
  (test (< ?b2 0))                              ;serve perché così finiamo in questa regola solo quando b = -1
  (test (>= (/ ?mc2 10) 0.4))
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  
  =>
    (assert (exec (step ?s) (action fire) (x ?x) (y ?y)))

    (assert (back-to-agent))
  
)

(defrule make-guess-row-not-exists
  (status (step ?s) (currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?g 0))
  (test (> ?mc1 0))
  (test (< ?b1 0))
  (test (>= (/ ?mc1 10) 0.4))
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  =>
  (assert (exec (step ?s) (action guess) (x ?x) (y ?y)))
  (assert(back-to-agent))
)

(defrule make-guess-col-not-exists
  (status (step ?s) (currently running))
  (moves (fires ?f) (guesses ?g))
  (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (test (> ?g 0))
  (test (> ?mc2 0))
  (test (< ?b2 0))
  (test (>= (/ ?mc2 10) 0.4))
  (not (exec (step ?) (action ?) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  (not (agent-guess (x ?x) (y ?y) (content ?)))
  =>
  (assert (exec (step ?s) (action guess) (x ?x) (y ?y)))
  (assert(back-to-agent))
)

(defrule back-to-agent (declare (salience 200))
  ?f1<-	(status (step ?s))
  ?bta <- (back-to-agent)
=>
  (retract ?bta)
  (pop-focus)
  (pop-focus)
  (pop-focus)
)

(defrule go-to-solve (declare (salience -300))
  (status (step ?s) (currently running))
 =>
  (focus AGENT_S)
)
