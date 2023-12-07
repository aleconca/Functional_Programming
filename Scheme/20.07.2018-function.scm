#lang racket

;1) Give a purely functional definition of fep, which takes a list (x1 x2 ... xn) and returns (x1 (x2 (... (xn (x1 x2 ... xn) xn) xn-1) ...) x1).

;2) Consider the following code; explain how it works, and what is the output of the call (run).


;1)
(define (fep L)
  (foldr (lambda(x y)(list x y x) ) (foldl cons '() L) L)
   )

(fep '(x1 x2 x3 x4 x5 x6 x7))

;2)
(define saved '()) ;global list

(define (push-k x)
  (set! saved (append saved (list x)))) ;instert element x in the global list tail

(define (poprun-k) ;remove elements from the heaad of the global list head and execute the continuation, if it is empty return false
  (if (null? saved)
      #f
      (let ((x (car saved)))
        (set! saved (cdr saved))
        (x)))) ;resume execution from x


(define (c1 x) ;save the current continuation to the global list and count the numer of the saved continuations
  (call/cc (lambda (k)
             (push-k k)))
  (set! x (+ x 1))
  (display "c1 ")(displayln x))


(define (c2 y) ;save the current continuation to the global list
  (call/cc (lambda (k)
             (push-k k)))
  (set! y (* y 2))
  (display "c2 ")(displayln y))


(define (run) ;call the procedures c1 and c2 to save continuations, then we pop and execute the continuations that was saved as the last one, i.e. c2.
              ;We will resume execution from the context of c2 so y=8. Simulates threads.
  (c1 0) (c2 2) (poprun-k)) ;these instructions are part of the contexts


(run)



;exec: (c1 0) (c2 2) (poprun-k)
;saved-cc= (c1) (c2)
;print : 1 4

;on popk resume from the context of (c1 0)
;exec: x+1 (c2 2) (poprun-k)
;saved-cc=  (c2) (c2)
;print : 1 4 2 4

;on popk resume from the context of (c2 2)
;exec: y*2 (poprun-k)
;saved-cc=  (c2)
;print : 1 4 2 4 8 


;on popk resume from the context of (c2 2)
;exec: y*2 (poprun-k)
;saved-cc=  empty
;print : 1 4 2 4 8 8 #f


