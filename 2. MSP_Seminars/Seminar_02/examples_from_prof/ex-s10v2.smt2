; The power operation ^ is Z3-specific.
(define-fun sqrt ((x Real)) Real (^ x 0.5))

(define-fun delta ((a Real) (b Real) (c Real)) Real
    (- (* b b) (* 4 a c)))

(define-fun findX ((a Real) (b Real) (c Real)) Real
    ( /
        (+ (- b) (sqrt (delta a b c)))
        (* a 2)
    ))

(declare-const a Real)
(declare-const b Real)
(declare-const c Real)

; precondition
(assert 
        (and 
          (= a 1)
          (<= 0 (delta a b c))
        )
)

; negated weakest precondition
(assert (not
  (or
    (and (< (delta a b c) 0) false) 
    (and
        (not (< (delta a b c) 0))
        (= 0 (+
            (* a (^ (findX a b c) 2) )
            (* b (findX a b c) )
            c
        ))
    )
  )
))

(check-sat); unsat, i.e. verifies :)