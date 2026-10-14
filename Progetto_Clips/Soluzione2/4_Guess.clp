;GUESSING ha il compito di mettere le guess nei punti in cui sicuramente c'è una barca, in base a ragionamenti induttivi e
;alle informazioni ricavate
(defmodule GUESS (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

;quando vede una k-cell con barca, fa una guess su quel punto (diminuisce di
;uno le missing su quella riga/colonna e aggiunge di uno le trovate su quella riga/colonna)
(defrule guess_k-cell
    (status (step ?s) (currently running))
    (k-cell(x ?x)(y ?y)(content ?c&~water))
    ?rv <- (row-val (row ?x) (boat ?n1) (missing-cell ?mc1) (found-boat ?fb1))
    ?cv <- (col-val (col ?y) (boat ?n2) (missing-cell ?mc2) (found-boat ?fb2))
    (not (exec (step ?) (action guess) (x ?x) (y ?y)))
=>
    (assert(exec(step ?s)(action guess)(x ?x)(y ?y)))
    (assert (agent-guess (x ?x) (y ?y) (content ?c)))
    (modify ?rv (missing-cell (- ?mc1 1)) (found-boat (+ ?fb1 1)))
    (modify ?cv (missing-cell (- ?mc2 1)) (found-boat (+ ?fb2 1)))
    (assert (back-to-agent))
)

(defrule put-guess-for-induction-top
  (agent-guess(x ?x) (y ?y) (content top))
=>
  (assert (make-guess (+ ?x 1) ?y))
)

(defrule put-guess-for-induction-bot
  (agent-guess(x ?x) (y ?y) (content bot))
=>
  (assert (make-guess (- ?x 1) ?y))
)

(defrule put-guess-for-induction-left
  (agent-guess(x ?x) (y ?y) (content left))
=>
  (assert (make-guess ?x (+ ?y 1))) 
)

(defrule put-guess-for-induction-right
  (agent-guess(x ?x) (y ?y) (content right))
=>
  (assert (make-guess ?x (- ?y 1))) 
)

(defrule put-guess-for-induction-middle
  (agent-guess(x ?x) (y ?y) (content middle))
=>
  (bind ?x-up (- ?x 1))
  (bind ?x-down (+ ?x 1))
  (bind ?y-left (- ?y 1))
  (bind ?y-right (+ ?y 1))
  (assert(guess-middle ?x ?x-up ?x-down ?y ?y-left ?y-right))
)

(defrule guess-middle-hor
  ?gm <- (guess-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  
  (or
    (eq ?x 0)                                                          ; se il middle si trova sulla prima riga
    (eq ?x 9)                                                          ; oppure se il middle si trova sull'ultima riga 
    (water (x ?x-up)(y ?y)) (water (x ?x-down)(y ?y))                  ; oppure se so che sopra o sotto c'è acqua
    (agent-guess(x ?x)(y ?y-left)) (agent-guess(x ?x)(y ?y-right))     ; oppure so che a sinistra o destra c'è una guess
  )                                                                    ;allora è orizzontale

=>

  (assert (make-guess ?x ?y-left))
  (assert (make-guess ?x ?y-right))
  (retract ?gm)

)

(defrule guess-middle-ver
  ?gm <- (guess-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  
  (or
    (eq ?y 0)                                                          ; se il middle si trova sulla prima colonna
    (eq ?y 9)                                                          ; oppure se il middle si trova sull'ultima colonna 
    (water (x ?x)(y ?y-left)) (water (x ?x)(y ?y-right))               ; oppure se so che a sinistra o destra c'è acqua
    (agent-guess (x ?x-up)(y ?y)) (agent-guess (x ?x-down)(y ?y))      ; oppure so che sopra o sotto c'è una guess
  )                                                                    ; allora è vericale

=>
  
  (assert (make-guess ?x-up ?y))
  (assert (make-guess ?x-down ?y))
  (retract ?gm)

)

(defrule guess-middle-remove
  ?gm <- (guess-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  (or
    (not(water (x ?x-up)(y ?y)))
    (not(water (x ?x-down)(y ?y)))
    (not(water (x ?x)(y ?y-left)))
    (not(water (x ?x)(y ?y-right)))
    (not(agent-guess(x ?x)(y ?y-left)))
    (not(agent-guess(x ?x)(y ?y-right)))
    (not(agent-guess (x ?x-up)(y ?y)))
    (not(agent-guess (x ?x-down)(y ?y)))
    (test (or (< ?x 0) (> ?x 9) (< ?y 0) (> ?y 9))))
  =>
  (retract ?gm)
)

; Se le missing cell sono uguali alla row-val meno le found-boat, allora significa che là andremo a guessare tutte le missing cell rimaste
(defrule guess-row
  ?rv <- (row-val (row ?x) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
  (test (eq ?mc (- ?b ?fb)))
  (test (neq ?mc 0))
  
  =>
    (assert (make-guess ?x 0))
    (assert (make-guess ?x 1))
    (assert (make-guess ?x 2))
    (assert (make-guess ?x 3))
    (assert (make-guess ?x 4))
    (assert (make-guess ?x 5))
    (assert (make-guess ?x 6))
    (assert (make-guess ?x 7))
    (assert (make-guess ?x 8))
    (assert (make-guess ?x 9))
)

(defrule guess-col
  ?cv <- (col-val (col ?y) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
  (test (eq ?mc (- ?b ?fb)))
  (test (neq ?mc 0))

  =>
    (assert (make-guess 0 ?y))
    (assert (make-guess 1 ?y))
    (assert (make-guess 2 ?y))
    (assert (make-guess 3 ?y))
    (assert (make-guess 4 ?y))
    (assert (make-guess 5 ?y))
    (assert (make-guess 6 ?y))
    (assert (make-guess 7 ?y))
    (assert (make-guess 8 ?y))
    (assert (make-guess 9 ?y))
)

(defrule guess-cell
  ?mg <- (make-guess ?x ?y)
  (status (step ?s) (currently running))
  (not (exec (step ?) (action guess) (x ?x) (y ?y)))                            ;controlla che non sia già stata guessata
  (not (water (x ?x) (y ?y)))                                                   ;controlla che non ci sia acqua
  ?rv <- (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))    ;prendo i valori di row-val per modificarli
  ?cv <- (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))    ;prendo i valori di col-val per modificarli
  =>
    (assert(exec(step ?s)(action guess)(x ?x)(y ?y)))                           ;eseguo la guess
    (assert (agent-guess (x ?x) (y ?y) (content not-know)))                     ;inserisco come conoscenza dell'agente
    (modify ?rv (missing-cell (- ?mc1 1)) (found-boat (+ ?fb1 1)))              ;modifico row-val
    (modify ?cv (missing-cell (- ?mc2 1)) (found-boat (+ ?fb2 1)))              ;modifico col-val
    (retract ?mg)
    (assert (back-to-agent))
)

(defrule guess-remove
    ?mg <- (make-guess ?x ?y)
    ;se c'è water in (x y) O se c'è già una guess in (x, y) O se x e y sono esterne alla griglia
    (or
        (water (x ?x)(y ?y))
        (agent-guess (x ?x) (y ?y) (content ?))
        (test (or (< ?x 0) (> ?x 9) (< ?y 0) (> ?y 9))))
=>
    (retract ?mg)
)

(defrule back-to-agent  (declare (salience 200))
  ?f1<-	(status (step ?s))
  ?bta <- (back-to-agent)
=>
  (retract ?bta)
  (pop-focus)
  (pop-focus)
)

(defrule go-to-random (declare (salience -300))
  (status (step ?s) (currently running))
 =>
  (focus RANDOM)
)