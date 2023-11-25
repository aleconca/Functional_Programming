#lang racket

;Consider the Foldable and Applicative type classes in Haskell. We want to implement something
;analogous in Scheme for vectors. Note: you can use the following library functions in your code: vectormap, vector-append.
;1) Define vector-foldl and vector-foldr.
;2) Define vector-pure and vector-<*>.


(define (vector-foldl vect)
  (let ((result (make-vector 0 vect)))
               (vector-map (lambda(x)(set! result (vector-append (make-vector 1 x) result)) ) vect)
               result)
  )
(vector-foldl #(1 2 3))

(define (vector-foldr vect)
  (let ((result (make-vector 0 vect)))
               (vector-map (lambda(x)(set! result (vector-append (make-vector 1 x) result)) ) (vector-foldl vect))
               result)
  )
(vector-foldr #(1 2 3))



