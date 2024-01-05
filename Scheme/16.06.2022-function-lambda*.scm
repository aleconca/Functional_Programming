#lang racket

;Define a list-to-compose pure function, which takes a list containing functions of one argument and
;returns their composition.
;E.g. (list-to-compose (list f g h)) is the function f(g(h(x)).


;input: list of functions, their common argument
(define (list-to-compose L)
   ;x represents the undefined common argument
   (lambda(x)(foldr (lambda(y acc)(y acc)) x L)) 
  )


(list-to-compose (list 'f 'g 'h)) ;is the function f(g(h(x))



 
