;GUESSING ha il compito di mettere le guess nei punti in cui sicuramente c'è una barca, in base a ragionamenti induttivi e
;alle informazioni ricavate

(defmodule AGENT_G (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

; ------------------------ gestione delle k-cell ------------------------
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

; ------------------ gestione delle agent-guess nei punti in cui si è sicuri ci sia una cella di qualche tipo ---------------------------
(defrule guess-row
  ?rv <- (row-val (row ?x) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
  (test (eq ?mc (- ?b ?fb)))
  (test (neq ?mc 0))
  
  =>
  (assert (make-guess ?x 0 not-know))
  (assert (make-guess ?x 1 not-know))
  (assert (make-guess ?x 2 not-know))
  (assert (make-guess ?x 3 not-know))
  (assert (make-guess ?x 4 not-know))
  (assert (make-guess ?x 5 not-know))
  (assert (make-guess ?x 6 not-know))
  (assert (make-guess ?x 7 not-know))
  (assert (make-guess ?x 8 not-know))
  (assert (make-guess ?x 9 not-know))
)

(defrule guess-col
  ?cv <- (col-val (col ?y) (boat ?b) (missing-cell ?mc) (found-boat ?fb))
  (test (eq ?mc (- ?b ?fb)))
  (test (neq ?mc 0))

  =>
  (assert (make-guess 0 ?y not-know))
  (assert (make-guess 1 ?y not-know))
  (assert (make-guess 2 ?y not-know))
  (assert (make-guess 3 ?y not-know))
  (assert (make-guess 4 ?y not-know))
  (assert (make-guess 5 ?y not-know))
  (assert (make-guess 6 ?y not-know))
  (assert (make-guess 7 ?y not-know))
  (assert (make-guess 8 ?y not-know))
  (assert (make-guess 9 ?y not-know))
)

; ----------- posizionamento di nuove agent-guess date delle agent-guess conosciute -----------------

(defrule put-guess-knowing-top
  (agent-guess(x ?x) (y ?y) (content top))
  =>
    (assert (make-guess (+ ?x 1) ?y middle-vertical))
    (assert (guessing-middle-or-bot (+ ?x 1) (+ ?x 2) ?y))
)

(defrule put-guess-knowing-bot
  (agent-guess (x ?x) (y ?y) (content bot))

  =>
    (assert (make-guess (- ?x 1) ?y middle-vertical))
    (assert (guessing-middle-or-top ?x (- ?x 1) (- ?x 2) ?y))
)

(defrule put-guess-knowing-left
  (agent-guess (x ?x) (y ?y) (content left))
  
  =>
    (assert (make-guess ?x (+ ?y 1) middle-horizzontal)) 
    (assert (guessing-middle-or-right ?x (+ ?y 1) (+ ?y 2)))
)

(defrule put-guess-knowing-right
  (agent-guess (x ?x) (y ?y) (content right))

  =>
    (assert (make-guess ?x (- ?y 1) middle-horizzontal))
    (assert (guessing-middle-or-left ?x ?y (- ?y 1) (- ?y 2)))
)

(defrule put-guess-knowing-middle
  (agent-guess (x ?x) (y ?y) (content middle))

  =>
      (bind ?x-up (- ?x 1))
      (bind ?x-down (+ ?x 1))
      (bind ?y-left (- ?y 1))
      (bind ?y-right (+ ?y 1))
      (assert(guessing-middle ?x ?x-up ?x-down ?y ?y-left ?y-right))
)


(defrule guess-middle-ver 
  ?gm <- (guessing-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  (or 
    (eq ?y 0)
    (eq ?y 9)
    (water (x ?x) (y ?y-left))
    (water (x ?x) (y ?y-right))
    (agent-guess (x ?x-up) (y ?y) (content ?))
    (agent-guess (x ?x-down) (y ?y) (content ?))
  )
  
  =>
    (assert (make-guess ?x-up ?y middle-vertical))
    (assert (guessing-middle-or-top ?x ?x-up (- ?x-up 1) ?y))
    (assert (make-guess ?x-down ?y middle-vertical))
    (assert (guessing-middle-or-bot ?x ?x-down (+ ?x-down 1) ?y))
)

(defrule guess-middle-hor 
  ?gm <- (guessing-middle ?x ?x-up ?x-down ?y ?y-left ?y-right)
  (or 
    (eq ?x 0)
    (eq ?x 9)
    (water (x ?x-up) (y ?y))
    (water (x ?x-down) (y ?y))
    (agent-guess (x ?x) (y ?y-left) (content ?))
    (agent-guess (x ?x) (y ?y-right) (content ?))
  )

  => 
    (assert (make-guess ?x ?y-left middle-horizzontal))
    (assert (guessing-middle-or-left ?x ?y ?y-left (- ?y-left 1)))
    (assert (make-guess ?x ?y-right middle-horizzontal))
    (assert (guessing-middle-or-right ?x ?y ?y-right (+ ?y-right 1)))
)

(defrule ver-case-next-water-middle-or-top
  (guessing-middle-or-top ? ?x1 ?x2 ?y)
  (boat-four-pieces (num ?n-4))
  ?ag <- (agent-guess (x ?x1) (y ?y) (content middle-vertical))
  (col-val (col ?y) (boat ?nb) (missing-cell ?mc) (found-boat ?fb))

  (or 
    (test (= ?x1 0))
    (water (x ?x2) (y ?y))
    (test (= ?n-4 0))
    (test (< ?nb 3))
  )

  => 
    (modify ?ag (content top))
)

(defrule ver-case-next-water-middle-or-bot
  (guessing-middle-or-top ? ?x1 ?x2 ?y)
  (boat-four-pieces (num ?n-4))
  ?ag <- (agent-guess (x ?x1) (y ?y) (content middle-vertical))
  (col-val (col ?y) (boat ?nb) (missing-cell ?mc) (found-boat ?fb))

  (or 
    (test (= ?x1 0))
    (water (x ?x2) (y ?y))
    (test (= ?n-4 0))
    (test (< ?nb 3))
  )

  =>
    (modify ?ag (content bot))  
)

(defrule ver-case-next-guess-middle-or-top-or-bot
  (or
    (guessing-middle-or-top ?x0 ?x1 ?x2 ?y)
    (guessing-middle-or-bot ?x0 ?x1 ?x2 ?y)
  )
  ?ag <- (agent-guess (x ?x1) (y ?y) (content middle-vertical))
  (and 
    (agent-guess (x ?x0) (y ?y) (content ?c0&~water))
    (agent-guess (x ?x2) (y ?y) (content ?c2&~water))
  )

  =>
    (modify ?ag (content middle))
)

(defrule hor-case-next-water-middle-or-left
  (guessing-middle-or-left ?x ? ?y1 ?y2)
  (boat-four-pieces (num ?n-4))
  ?ag <- (agent-guess (x ?x) (y ?y1) (content middle-horizzontal))
  (row-val (row ?x) (boat ?nb) (missing-cell ?mc) (found-boat ?fb))

  (or 
    (test (= ?y1 0))
    (water (x ?x) (y ?y2))
    (test (= ?n-4 0))
    (test (< ?nb 3))
  )

  =>
    (modify ?ag (content left))
)

(defrule hor-case-next-water-middle-or-right
  (guessing-middle-or-left ?x ? ?y1 ?y2)
  (boat-four-pieces (num ?n-4))
  ?ag <- (agent-guess (x ?x) (y ?y1) (content middle-horizzontal))
  (row-val (row ?x) (boat ?nb) (missing-cell ?mc) (found-boat ?fb))

  (or 
    (test (= ?y1 0))
    (water (x ?x) (y ?y2))
    (test (= ?n-4 0))
    (test (< ?nb 3))
  )

  =>
    (modify ?ag (content right))
)

(defrule hor-case-next-guess-middle-or-left-or-right
  (or
    (guessing-middle-or-left ?x ?y0 ?y1 ?y2)
    (guessing-middle-or-right ?x ?y0 ?y1 ?y2)
  )
  ?ag <- (agent-guess (x ?x) (y ?y1) (content middle-horizzontal))
  (and 
    (agent-guess (x ?x) (y ?y0) (content ?c0&~water))
    (agent-guess (x ?x) (y ?y2) (content ?c2&~water))
  )

  => 
    (modify ?ag (content middle))
)

; --------------- applicazione delle exec guess e delle agent guess -----------------------

(defrule guess-cell
  ?mg <- (make-guess ?x ?y ?c)
  (not (exec (step ?) (action guess) (x ?x) (y ?y)))
  (not (water (x ?x) (y ?y)))
  ?rv <- (row-val (row ?x) (boat ?b1) (missing-cell ?mc1) (found-boat ?fb1))
  ?cv <- (col-val (col ?y) (boat ?b2) (missing-cell ?mc2) (found-boat ?fb2))
  (status (step ?s) (currently running))

  =>
    (assert(exec(step ?s)(action guess)(x ?x)(y ?y)))
    (assert (agent-guess (x ?x) (y ?y) (content ?c)))
    (modify ?rv (missing-cell (- ?mc1 1)) (found-boat (+ ?fb1 1)))
    (modify ?cv (missing-cell (- ?mc2 1)) (found-boat (+ ?fb2 1)))
    (retract ?mg)
    (assert (back-to-agent))
)

(defrule guess-remove
    ?mg <- (make-guess ?x ?y ?)
    ;se c'è water in (x y) O se c'è già una guess in (x, y) O se x e y sono esterne alla griglia
    (or (water (x ?x)(y ?y)) (agent-guess (x ?x) (y ?y) (content ?)) (test (or (< ?x 0) (> ?x 9) (< ?y 0) (> ?y 9))))
=>
    (retract ?mg)
)

; ------------------ barca da 4 pezzi ----------------------------------------

(defrule boat-4-pieces-found-ver
  ?f <- (boat-four-pieces (num ?num))
  (test (> ?num 0))
  (agent-guess (x ?x1) (y ?y) (content ?c1))
  (agent-guess (x ?x2) (y ?y) (content ?c2))
  (agent-guess (x ?x3) (y ?y) (content ?c3))
  (agent-guess (x ?x4) (y ?y) (content ?c4))
  (test(eq ?x2 (+ 1 ?x1)))
  (test(eq ?x3 (+ 1 ?x2)))
  (test(eq ?x4 (+ 1 ?x3)))
  (test(eq ?c1 top))
  (test(eq ?c2 middle))
  (test(eq ?c3 middle))
  (test(eq ?c4 bot))  

  => 
    (modify ?f (num (- ?num 1)))
)

(defrule boat-4-pieces-found-hor
  ?f <- (boat-four-pieces (num ?num))
  (test (> ?num 0))
  (agent-guess (x ?x) (y ?y1) (content ?c1))
  (agent-guess (x ?x) (y ?y2) (content ?c2))
  (agent-guess (x ?x) (y ?y3) (content ?c3))
  (agent-guess (x ?x) (y ?y4) (content ?c4))
  (test(eq ?y2 (+ 1 ?y1)))
  (test(eq ?y3 (+ 1 ?y2)))
  (test(eq ?y4 (+ 1 ?y3)))
  (test(eq ?c1 left))
  (test(eq ?c2 middle))
  (test(eq ?c3 middle))
  (test(eq ?c4 right))
  

  => 
  
    (modify ?f (num (- ?num 1)))
)

; -----------------------------per spostarsi tra i moduli--------------------------------------

(defrule back-to-agent  (declare (salience 200))
  ?f1<-	(status (step ?s))
  ?bta <- (back-to-agent)
=>
  (retract ?bta)
  (pop-focus)
  (pop-focus)
)


(defrule go-to-random (declare (salience -350))
  (status (step ?s) (currently running))
 =>
  (focus AGENT_R)
)

