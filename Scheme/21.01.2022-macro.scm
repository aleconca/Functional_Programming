#lang racket

;Define a new construct called block which creates two scopes for variables, declared after the
;scopes, with two different binding. E.g. the evaluation of the following code:

;(block
; ((displayln (+ x y))
; (displayln (* x y))
; (displayln (* z z)))
; then
; ((displayln (+ x y))
; (displayln (* z x)))
; where (x <- 12 3)(y <- 8 7)(z <- 3 2))

;should show on the screen:
;20
;96
;9
;10
;6

;define name of the contruct
(define-syntax block
  ;define a sort of 'lambda' that takes all the wxtra literal-ids we need to do pattern-matching
  (syntax-rules ( then where <-)
    ;define the pattern to match
    ((_ (exp1 ...) then (exp2 ...) where (var <- val1 val2) ...)
     ;define the desired behaviour you want to have once the pattern is matched
     (begin
       (let ((var val1) ...)
         exp1 ...)
       (let ((var val2) ...)
         exp2 ...);beware that you always need a space between id and elipsis
       )
     )
    )
  )

;test
(block
 ((displayln (+ x y))
  (displayln (* x y))
  (displayln (* z z)))
 then
 ((displayln (+ x y))
  (displayln (* z x)))
 where (x <- 12 3)(y <- 8 7)(z <- 3 2))
