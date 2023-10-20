#lang racket

;Define a list-to-compose pure function, which takes a list containing functions of one argument and
;returns their composition.
;E.g. (list-to-compose (list f g h)) is the function f(g(h(x)).



(define (list-to-compose L);define the function 
  ;cons node (a . b) but b is still a cons node (a . (c . d)) then (a . (c . (e . f))), if stop f = Null
  ;we need a lambda to pass the argument x
  (let (a car(L))
    (lambda(x)(apply a x)))
  (list-to-compose (cdr L)))
