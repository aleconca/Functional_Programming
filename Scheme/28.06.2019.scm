#lang racket

;Consider this data definition in Haskell: data Tree a = Leaf a | Branch (Tree a) a (Tree a)
;Define an OO analogous of this data structure in Scheme using the technique of "closure as classes" as seen
;in class, defining the map and print methods, so that:

;(define t1 (Branch (Branch (Leaf 1) -1 (Leaf 2)) -2 (Leaf 3)))
;((t1 'map (lambda (x) (+ x 1))) 'print)
;should display: (Branch (Branch (Leaf 2) 0 (Leaf 3)) -1 (Leaf 4))



(define (Branch t1 x t2)
  
   (define (print)
     (display "(Branch ")
     (t1 'print)
     (display " ")
     (display x)
     (display " ")
     (t2 'print)
     (display ")")
     )

  (define (map f)
    (Branch (t1 'map f) (f x) (t2 'map f)))

   (lambda (message . args)
     (apply (case message
              ((map) map)
              ((print) print)
              (else (error "Unknown method")))
            args))
   )
  
(define (Leaf x)
  
   (define (print)
     (display "(Leaf ")
     (display " ")
     (display x)
     (display " ")
     )

  (define (map f)
    (Leaf (f x)) )

   (lambda (message . args)
     (apply (case message
              ((map) map)
              ((print) print)
              (else (error "Unknown method")))
            args))
   )
  


(define t1 (Branch (Branch (Leaf 1) -1 (Leaf 2)) -2 (Leaf 3)))
((t1 'map (lambda (x) (+ x 1))) 'print)
;should display: (Branch (Branch (Leaf 2) 0 (Leaf 3)) -1 (Leaf 4))
