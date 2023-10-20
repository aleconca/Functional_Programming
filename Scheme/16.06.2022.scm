#lang racket

;Define a list-to-compose pure function, which takes a list containing functions of one argument and
;returns their composition.
;E.g. (list-to-compose (list f g h)) is the function f(g(h(x)).

;define function
(define (list-to-compose f . rest)
  
  (if (null? rest)
      ; If there are no more functions in the list, return a lambda function
      (lambda (x) (f x))
      
      ; Else, recursively compose the functions
      (list-to-compose (compose f (car rest)) (cdr rest)))
  
  )


  ;Another solution:
  (define (list-to-compose lst)
   (lambda (x)
           (foldr (lambda (y acc) (y acc)) x lst)))

