; declare variables
(declare-const X Bool)
(declare-const Y Bool)
(declare-const Z Bool)

; define formula (𝑋⇒𝑌⇒𝑍)∧𝑋
(assert (=> X Y Z))
(assert X)

; (assert 
;     (and
;         (=> X Y Z)
;         X
;     )
; )

(check-sat)

(get-model) ; fails if unsat
