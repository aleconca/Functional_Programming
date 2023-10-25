#lang racket

;The fold operations are very general, and can be used to implement many higher order functions.


;1) Define map as a fold (left or right, your choice).

(define (fold-map bf dest L)
  (if (null? L)
      dest
      (fold-map bf (cons (bf (car L)) dest) (cdr L))))

 
(fold-map (lambda(x)(+ x 1)) '() '(1 2 3))


;2) Define filter as a fold (left or right, your choice).

(define (fold-filter bf dest L)
  (if (null? L)
      dest
      (fold-filter bf (set! dest (bf (car L))) (cdr L))))

 
(fold-map (lambda(x)(< x 1)) '() '(1 -2 3))
