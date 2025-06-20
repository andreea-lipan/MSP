; Note: This solution is more complex, the python one is simpler

; Exercise: Placement of wedding guests
; We have to assign chairs to three guests, called Alice, Bob, and Charlie
; There are three chairs in a row, called Left, Middle, and Right
; Alice does not want to sit on the leftmost chair
; Alice does not want to sit next to Charlie
; Bob does not want to sit to the right of Charlie
; Is it possible to assign our guests such that they are all happy?

; We introduce a variable XY to indicate that guest X sits in chair Y
(declare-const AL Bool)
(declare-const AM Bool)
(declare-const AR Bool)
(declare-const BL Bool)
(declare-const BM Bool)
(declare-const BR Bool)
(declare-const CL Bool)
(declare-const CM Bool)
(declare-const CR Bool)

(define-fun tripleXor ((a Bool) (b Bool) (c Bool)) Bool 
    (and
        (or a b c)      ; macar una dintre ele sa fie adevarata
        (=> a (and (not b) (not c)))
        (=> b (and (not a) (not c)))
        (=> c (and (not b) (not a)))
    ))

; Alice does not want to sit on the leftmost chair
(assert (not AL))

; Alice does not want to sit next to Charlie
(assert 
    (and
        (=> (or AL AR) (not CM))
        (=> AM (and (not CL) (not CR)))
    )
)

; Bob does not want to sit to the right of Charlie
(assert
    (and
        ; (=> CL (and (not BM) (not BR)))
        (=> CL (not BM))
        (=> CM (not BR))
    )
)

; Each person gets a chair
(assert
    (and
        (or AL AM AR)
        (or BL BM BR)
        (or CL CM CR)
    )
)

; Every person gets at most one chair
(assert
    (and
        (tripleXor AL AM AR)
        (tripleXor BL BM BR)
        (tripleXor CL CM CR)
    )
)

; Every chair gets at most one person
(assert
    (and
        (tripleXor AL BL CL)
        (tripleXor AM BM CM)
        (tripleXor AR BR CR)
    )
)

(check-sat)


