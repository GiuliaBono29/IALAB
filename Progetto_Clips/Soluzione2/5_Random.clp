;RANDOM ha il compito di fare guess e fire attorno alle caselle dove abbiamo una agent-guess
(defmodule RANDOM (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

;guessa attorno a una guess di cui non so il contenuto
(defrule guessing
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content not-know))
  (moves (fires ?f) (guesses ?g))
  (test (= ?f 0))
  (test (> ?g 0))
  =>
    (bind ?x-up (- ?x 1))
    (bind ?x-down (+ ?x 1))
    (bind ?y-left (- ?y 1))
    (bind ?y-right (+ ?y 1))
    (assert (make-random-guess ?x ?y-left))
    (assert (make-random-guess ?x ?y-right))
    (assert (make-random-guess ?x-up ?y))
    (assert (make-random-guess ?x-down ?y))
)

(defrule guess-random-cell
  ?mrg <- (make-random-guess ?x ?y)
  (moves (fires ?f) (guesses ?g))
  (test (> ?g 0))
  (status (step ?s) (currently running))
  (not (exec (step ?) (action guess) (x ?x) (y ?y)))                            ;controlla che non sia già stata guessata
  (not (water (x ?x) (y ?y)))  
  (test(>= ?x 0))
  (test(<= ?x 9))
  (test(>= ?y 0))
  (test(<= ?y 9))
=>
    (assert(exec(step ?s)(action guess)(x ?x)(y ?y)))                           ;eseguo la guess
    (assert (agent-guess (x ?x) (y ?y) (content not-know)))                     ;inserisco come conoscenza dell'agente
    (retract ?mrg)
    (assert (back-to-agent))
)

(defrule guess-random-remove
    ?mrg <- (make-random-guess ?x ?y)
    ;se c'è water in (x y) O se c'è già una guess in (x, y) O se x e y sono esterne alla griglia
    (or
        (water (x ?x)(y ?y))
        (agent-guess (x ?x) (y ?y) (content ?))
        (test (or (< ?x 0) (> ?x 9) (< ?y 0) (> ?y 9))))
=>
    (retract ?mrg)
)

;i seguenti metodi fatto fire attorno a una guess in base al contenuto 
(defrule firing_sub (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content sub))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?x-up (- ?x 2))
    (bind ?x-down (+ ?x 2))
    (bind ?y-left (- ?y 2))
    (bind ?y-right (+ ?y 2))
    (assert (fire-point ?x ?y-left))
    (assert (fire-point ?x ?y-right))
    (assert (fire-point ?x-up ?y))
    (assert (fire-point ?x-down ?y))
)
 
(defrule firing_top (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content top))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?x-down (+ ?x 2))
    (assert(fire-point ?x-down ?y))
)

(defrule firing_bot (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content bot))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?x-up (- ?x 2))
    (assert(fire-point ?x-up ?y))
)

(defrule firing_left (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content left))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?y-right (+ ?y 2))
    (assert (fire-point ?x ?y-right))
)

(defrule firing_right (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content right))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?y-left (- ?y 2))
    (assert (fire-point ?x ?y-left))
)

(defrule firing_middle (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content middle))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?x-up (- ?x 1))
    (bind ?x-down (+ ?x 1))
    (bind ?y-left (- ?y 1))
    (bind ?y-right (+ ?y 1))
    (assert(fire-middle ?x ?x-up ?x-down ?y ?y-left ?y-right))
)

(defrule firing_not-know (declare (salience 100))
  (status (step ?s) (currently running))
  (agent-guess(x ?x) (y ?y) (content not-know))
  (moves (fires ?f) (guesses ?))
  (test (> ?f 0))
  =>
    (bind ?x-up (- ?x 2))
    (bind ?x-down (+ ?x 2))
    (bind ?y-left (- ?y 2))
    (bind ?y-right (+ ?y 2))
    (assert (fire-point ?x ?y-left))
    (assert (fire-point ?x ?y-right))
    (assert (fire-point ?x-up ?y))
    (assert (fire-point ?x-down ?y))
)

(defrule fire-middle-hor (declare (salience 100))
  ?fm <- (fire-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  
  (or
    (eq ?x 0)                                                          ; se il middle si trova sulla prima riga
    (eq ?x 9)                                                          ; oppure se il middle si trova sull'ultima riga 
    (water (x ?x-up)(y ?y)) (water (x ?x-down)(y ?y))                  ; oppure se so che sopra o sotto c'è acqua
    (agent-guess(x ?x)(y ?y-left)) (agent-guess(x ?x)(y ?y-right))     ; oppure so che a sinistra o destra c'è una guess
  )                                                                    ;allora è orizzontale
=>
  (assert (fire-point ?x ?y-left))
  (assert (fire-point ?x ?y-right))
  (retract ?fm)

)

(defrule fire-middle-ver (declare (salience 100))
  ?fm <- (fire-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  (or
    (eq ?y 0)                                                          ; se il middle si trova sulla prima colonna
    (eq ?y 9)                                                          ; oppure se il middle si trova sull'ultima colonna 
    (water (x ?x)(y ?y-left)) (water (x ?x)(y ?y-right))               ; oppure se so che a sinistra o destra c'è acqua
    (agent-guess (x ?x-up)(y ?y)) (agent-guess (x ?x-down)(y ?y))      ; oppure so che sopra o sotto c'è una guess
  )                                                                    ; allora è vericale
=>
  (assert (fire-point ?x-up ?y))
  (assert (fire-point ?x-down ?y))
  (retract ?fm)

)

(defrule fire-middle-remove
  ?fm <- (fire-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
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
  (retract ?fm)
)

(defrule fire-cell (declare (salience 100))
    ?fp <- (fire-point ?x ?y)
    (moves (fires ?f) (guesses ?g))
    (test (> ?f 0))
    (status (step ?s) (currently running))
    (not(exec (step ?) (action fire) (x ?x) (y ?y)))                         ;non è una casella in cui ho già sparato
    (not (water (x ?x)(y ?y)))                                               ;controllo di non averla segnata come water
    (or (not (agent-guess(x ?x) (y ?y) (content ?))) (test (= ?g 0)))        ;non devo aver fatto delle guess
    (test (>= ?x 0))
    (test (<= ?x 9))
    (test (>= ?y 0))
    (test (<= ?y 9))
=>
    (assert (exec (step ?s) (action fire) (x ?x) (y ?y)))
    (retract ?fp)
    (assert (back-to-agent))
)

(defrule delete-fire-point (declare (salience 100))
    ?fp <- (fire-point ?x ?y)
    (or
        (exec (step ?) (action fire) (x ?x) (y ?y))     ;non è una casella in cui ho già sparato
        (water (x ?x)(y ?y))                            ;controllo di non averla segnata come water
        (agent-guess(x ?x) (y ?y) (content ?))          ;non devo aver fatto delle guess
        (test (< ?x 0))
        (test (> ?x 9))
        (test (< ?y 0))
        (test (> ?y 9))
    )
=>
    (retract ?fp)
)

(defrule init-random (declare (salience 400))
  =>
  (seed (round (time)))
)

(defrule back-to-agent (declare (salience 300))
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
  (focus SOLVE)
)
