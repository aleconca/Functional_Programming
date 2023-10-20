#lang racket

;Define a let** construct that behaves like the standard let*, but gives to variables provided without a binding the
;value of the last defined variable. It also contains a default value, stated by a special keyword def:, to be used if the
;first variable is given without binding.
;For example:
;(let** def: #f
; (a (b 1) (c (+ b 1)) d (e (+ d 1)) f)
; (list a b c d e f))
;should return '(#f 1 2 2 3 3), because a assumes the default value #f, while d = c and f = e.


;I would use a macro to define let** construct
(define-syntax let** 
  (define syntax-rules (def:) ;we do need to pass an additional keyword

    (

    ;start with the base cases
     ((_ def: v (var) istr... ) ;v is the input default value 
      (lambda (var) ( istr ...) v)

     ((_ def: v ((var val)) istr... )
      (lambda (var) (istr ...) val)

    ;general cases
     (_ def: v ((var val) . rest) istr... ) ;note that the rest is not necessarily a (var val) but something else, i.e. it is a list of something
      (lambda (var) (let** def: val rest istr ...) val) ; to know whic was the last defined we change the default value

     (_ def: v ((var) . rest) istr... )
      (lambda (var) (let** def: v rest istr ...) v)  ;pass the def: value to obtain a match in the recursive call, as above 

    ) )
