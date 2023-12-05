#lang racket

;Define a pure function f with a variable number of arguments, that, when called like (f x1 x2 .. xn), returns:
;(xn (xn-1 ( .. (x1 (xn xn-1 .. x1))..). Function f must be defined using only fold operations for loops.


(define (f . args)
  (foldr (lambda(x y)(cons x (list y) )) (foldl cons '() args) args)
  )

(f 'x1 'x2 'x3 'x4)
;'(x1 (x2 (x3 (x4 (x4 x3 x2 x1)))))
