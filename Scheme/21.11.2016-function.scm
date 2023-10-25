#lang racket

;The fold operations are very general, and can be used to implement many higher order functions.


;1) Define map as a fold (left or right, your choice).

(define (fold-map bf dest L)
  (if (null? L)
      dest
      (fold-map bf (cons (bf (car L)) dest) (cdr L))))

 
(fold-map (lambda(x)(+ x 1)) '() '(1 2 3))
;'(4 3 2)

;2) Define filter as a fold (left or right, your choice).

(define (fold-filter bf dest L)
  (if (null? L)
      dest
      (fold-filter bf (set! dest (bf (car L))) (cdr L))))

 
(fold-map (lambda(x)(< x 1)) '() '(1 -2 3))
;'(#f #t #f)

;ERROR: 
;-remember map and filter take as input two arguments
;-should have used a foldr in both cases directly

;SOL: easier than expected

(define (fmap f l)
  ;y is initialized as 0, then used as an accumulator
  ;ex. iteration 1: x=3, y=0 -> cons=(4)
  (foldr (lambda (x y) (cons (f x) y)) '() l))

(fmap (lambda(x)(+ x 1)) '(1 2 3))
;'(2 3 4)

(define (ffilter p l)
  (foldr (lambda (x y)(if (p x)(cons x y) y)) '() l))



