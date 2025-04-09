; Solving the SAT problem means finding an assignment that makes a formula true.
; How can we use it to *prove* a law of propositional logic?

(declare-const x Bool)
(declare-const y Bool)

(push)
(echo "De Morgan's law: !(x && y) == (!x || !y)")

(define-fun DeMorgan () Bool 
    (= 
        (not (and x y) )
        (or (not x) (not y))
    )
)

; (assert 
;     (= 
;         (not (and x y) )
;         (or (not x) (not y))
;     )
; )
(assert (not DeMorgan))
(check-sat)
(echo "What does this tell us?")
(pop)
