#lang racket

;Consider this data definition in Haskell: data Tree a = Leaf a | Branch (Tree a) a (Tree a).

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
    (display ")"))
  
  (define (map f)
    (Branch (t1 'map f) (f x) (t2 'map f)))
  
  (lambda (message . args)
    (apply
     (case message
       ((print) print)
       ((map) map)
       (else (error "Unknown")))
     args))

  )


(define (Leaf x)
  
  (define (print)
    (display "(Leaf ")
    (display x)
    (display ")"))
  
  (define (map f)
    (Leaf (f x)))
  
  (lambda (message . args)
    (apply
     (case message
       ((print) print)
       ((map) map)
       (else (error "Unknown")))
     args))

  )

;t1 is expected to be a function or object that has a method called 'print.
;(t1 'print) is a function call with two arguments: the first is the function or object t1,
;and the second is the symbol 'print, which is treated as a message or method name.
