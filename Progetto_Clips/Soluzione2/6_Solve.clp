;SOLVE fa l'esecuzione della solve
(defmodule SOLVE (import MAIN ?ALL) (import ENV ?ALL) (import AGENT ?ALL) (export ?ALL))

(defrule final-solve
  (status (step ?s)(currently running))
  =>
  (assert (exec (step ?s)(action solve)))
  (assert (back-to-agent))
)

(defrule back-to-agent (declare (salience -100))
  ?f1<-	(status (step ?s))
  ?bta <- (back-to-agent)
=>
  (retract ?bta)
  (pop-focus)
  (pop-focus)
  (pop-focus)
  (pop-focus)
)