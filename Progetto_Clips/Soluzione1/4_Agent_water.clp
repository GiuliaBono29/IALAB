;WATERING ha il compito di mettere l'acqua nei punti dove è sicuro che ci sia l'acqua
;C'è un fatto per ogni cella con l'acqua -> water(x)(y)
;In che casi possiamo avere l'acqua in una cella?
;A) abbiamo l'indizio tramite la k-cell (x)(y)(water) -> water(x)(y)
;B) sappiamo tramite la k-per-row che la riga r ha 0 barche -> creo una water(r)(y) per ogni colonna
;C) sappiamo tramite la k-per-col che la colonna c ha 0 barche -> creo una water(x)(c) per ogni riga 

(defmodule AGENT_W (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

;quando vede una k-cell con acqua, dice che c'è della water (diminuisce di uno le
;missing su quella riga/colonna)
(defrule water_k-cell
    (status (step ?s) (currently running))
    (k-cell(x ?x)(y ?y)(content water))
    (not (water (x ?x)(y ?y)))
    ?rv <- (row-val (row ?x) (boat ?n1) (missing-cell ?mc1) (found-boat ?fb1))
    ?cv <- (col-val (col ?y) (boat ?n2) (missing-cell ?mc2) (found-boat ?fb2))
=>
    (assert(water(x ?x)(y ?y)))
    (modify ?rv (missing-cell (- ?mc1 1)))
    (modify ?cv (missing-cell (- ?mc2 1))) 
)

;se su una riga le barche da trovare sono state trovate tutte
;attiva la flag make-water per ogni cella della riga
(defrule water-row
    (row-val (row ?r) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
    (test (eq (- ?b ?fb) 0))  ;se non vengono dati i valori k-per-row non si attiverà mai la regola
=>
    (assert (make-water ?r 0))
    (assert (make-water ?r 1))
    (assert (make-water ?r 2))
    (assert (make-water ?r 3))
    (assert (make-water ?r 4))
    (assert (make-water ?r 5))
    (assert (make-water ?r 6))
    (assert (make-water ?r 7))
    (assert (make-water ?r 8))
    (assert (make-water ?r 9))
)

;se su una colonna le barche da trovare sono state trovate tutte
;attiva la flag make-water per ogni cella della colonna
(defrule water-col
    (col-val (col ?c) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
    (test (eq (- ?b ?fb) 0))  ;se non vengono dati i valori k-per-col non si attiverà mai la regola
=>
    (assert (make-water 0 ?c))
    (assert (make-water 1 ?c))
    (assert (make-water 2 ?c))
    (assert (make-water 3 ?c))
    (assert (make-water 4 ?c))
    (assert (make-water 5 ?c))
    (assert (make-water 6 ?c))
    (assert (make-water 7 ?c))
    (assert (make-water 8 ?c))
    (assert (make-water 9 ?c))
)

;se una cella è segnata come make-water, allora controllo che non sia una guess
;e che non sia gia segnata come water, in caso segno come water e diminuisco di 1
;i valori missing su col-val e row-val. Tolgo anche il vatto make-water
(defrule water-cell
    ?mw <- (make-water ?x ?y)
    (not(exec (step ?) (action guess) (x ?x) (y ?y)))       ;non è una casella guessata
    (not (water (x ?x)(y ?y)))                              ;controllo di non averla già segnata
    ?rv <- (row-val (row ?x) (boat ?n1) (missing-cell ?mc1) (found-boat ?fb1))
    ?cv <- (col-val (col ?y) (boat ?n2) (missing-cell ?mc2) (found-boat ?fb2))
=>

    (assert (water (x ?x) (y ?y)))
    (modify ?rv (missing-cell (- ?mc1 1)))
    (modify ?cv (missing-cell (- ?mc2 1))) 
    (retract ?mw)
)

;un secondo metodo togliere i make-water in caso avesse passato i controlli del metodo
;presecente
(defrule water-remove
    ?mw <- (make-water ?x ?y)
    ;se c'è water in (x y) O se c'è una guess in (x, y) O se x e y sono esterne alla griglia
    (or (water (x ?x)(y ?y)) (agent-guess (x ?x) (y ?y) (content ?)) (test (or (< ?x 0) (> ?x 9) (< ?y 0) (> ?y 9))))
=>
    (retract ?mw)
)

(defrule put-water-general
  (agent-guess(x ?x) (y ?y) (content ?c))
  
  =>
  (assert (make-water (- ?x 1) (- ?y 1)))
  (assert (make-water (+ ?x 1) (- ?y 1)))
  (assert (make-water (+ ?x 1) (+ ?y 1)))
  (assert (make-water (- ?x 1) (+ ?y 1)))
  
)

(defrule put-water-sub
  (agent-guess(x ?x) (y ?y) (content sub))
=>
  (assert (make-water ?x (- ?y 1)))
  (assert (make-water (+ ?x 1) ?y))
  (assert (make-water ?x (+ ?y 1)))
  (assert (make-water (- ?x 1) ?y))
)

(defrule put-water-up
  (agent-guess(x ?x) (y ?y) (content top))
=>
  (assert (make-water ?x (- ?y 1)))
  (assert (make-water ?x (+ ?y 1)))
  (assert (make-water (- ?x 1) ?y))
)

(defrule put-water-bot
  (agent-guess(x ?x) (y ?y) (content bot))
=>
  (assert (make-water ?x (- ?y 1)))
  (assert (make-water (+ ?x 1) ?y))
  (assert (make-water ?x (+ ?y 1)))
)

(defrule put-water-left
  (agent-guess(x ?x) (y ?y) (content left))
=>
  (assert (make-water ?x (- ?y 1)))
  (assert (make-water (+ ?x 1) ?y))
  (assert (make-water (- ?x 1) ?y))
)

(defrule put-water-right
  (agent-guess(x ?x) (y ?y) (content right))
=>
  (assert (make-water (+ ?x 1) ?y))
  (assert (make-water ?x (+ ?y 1)))
  (assert (make-water (- ?x 1) ?y))
)

(defrule put-water-middle
  (agent-guess(x ?x) (y ?y) (content middle))
=>
  (bind ?x-up (- ?x 1))
  (bind ?x-down (+ ?x 1))
  (bind ?y-left (- ?y 1))
  (bind ?y-right (+ ?y 1))
  (assert(water-middle ?x ?x-up ?x-down ?y ?y-left ?y-right))
)


(defrule water-middle-hor
  ?wm <- (water-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  
  (or
    (eq ?x 0)                                                          ; se il middle si trova sulla prima riga
    (eq ?x 9)                                                          ; oppure se il middle si trova sull'ultima riga 
    (water (x ?x-up)(y ?y)) (water (x ?x-down)(y ?y))                  ; oppure se so che sopra o sotto c'è acqua
    (agent-guess(x ?x)(y ?y-left)) (agent-guess(x ?x)(y ?y-right))     ; oppure so che a sinistra o destra c'è una guess
  )                                                                    ;allora è orizzontale
=>

  (assert (make-water ?x-up ?y))
  (assert (make-water ?x-down ?y))
  (retract ?wm)

)

(defrule water-middle-ver
  ?wm <- (water-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  (or
    (eq ?y 0)                                                          ; se il middle si trova sulla prima colonna
    (eq ?y 9)                                                          ; oppure se il middle si trova sull'ultima colonna 
    (water (x ?x)(y ?y-left)) (water (x ?x)(y ?y-right))               ; oppure se so che a sinistra o destra c'è acqua
    (agent-guess (x ?x-up)(y ?y)) (agent-guess (x ?x-down)(y ?y))      ; oppure so che sopra o sotto c'è una guess
  )                                                                    ; allora è vericale
=>
  
  (assert (make-water ?x ?y-left))
  (assert (make-water ?x ?y-right))
  (retract ?wm)

)

(defrule go-to-guess (declare (salience -300))
  (status (step ?s) (currently running))
 =>
    (focus AGENT_G)
)