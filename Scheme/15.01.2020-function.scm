#lang racket

;Consider the Foldable and Applicative type classes in Haskell. We want to implement something
;analogous in Scheme for vectors. Note: you can use the following library functions in your code: vectormap, vector-append.
;1) Define vector-foldl and vector-foldr.
;2) Define vector-pure and vector-<*>.


(define (vector-foldr f i v)
  (let loop ((cur (- (vector-length v) 1))
             (out i))
    (if (< cur 0)
        out
        (loop (- cur 1) (f (vector-ref v cur) out)))))


(define (vector-foldl f i v)
  (let loop ((cur 0)
             (out i))
    (if (>= cur (vector-length v))
        out
        (loop (+ cur 1) (f (vector-ref v cur) out)))))

(define (vector-concat-map f v)
  (vector-foldr vector-append #() (vector-map f v)))

(define vector-pure vector)

(define (vector-<*> fs xs)
  (vector-concat-map (lambda (f) (vector-map f xs)) fs))
