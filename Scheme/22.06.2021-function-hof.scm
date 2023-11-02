#lang racket

;Define a function mix which takes a variable number of arguments x0 x1 x2 ... xn, the first one a function,
;and returns the list (x1 (x2 ... (x0(x1) x0(x2) ... x0(xn)) xn) xn-1) ... x1).
;E.g.
;(mix (lambda (x) (* x x)) 1 2 3 4 5)
;returns: '(1 (2 (3 (4 (5 (1 4 9 16 25) 5) 4) 3) 2) 1)

;define a function that takes as input a function and a list
(define (mix f L)

  (foldr ((lambda(x y)(x y x)) (map f L) L))
  
  )

;difficulty: how can I create that structure?
;compute foldr and foldl and store them
;(a*(b*(c)))
;(c*(b*(a*)))
;then concatenate this two separated by a middle list (apply f L
;error-> I would get an incorrect concatenation
;it is easier to apply a lambda to each element of L, starting form (map f L) while folding right.



