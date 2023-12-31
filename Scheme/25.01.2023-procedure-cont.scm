#lang racket

;We want to implement a for-each/cc procedure which takes a condition, a list and a body and performs a for-each.
;The main difference is that, when the condition holds for the current value, the continuation of the body is stored in
;a global queue of continuations. We also need an auxiliary procedure, called use-cc, which extracts and call the
;oldest stored continuation in the global queue, discarding it.

;E.g. if we run:
;(for-each/cc odd?
 ;'(1 2 3 4)
 ;(lambda (x) (displayln x)))
;two continuations corresponding to the values 1 and 3
;will be stored in the global queue.


;SOL:
(define queue '())

(define (use-cc)
  (if (not (null? queue))
      (let (c (car queue)) 
        (set! queue (cdr queue))
        (c))
  )    
 )

(define (for-each/cc cond L body)
  ;CONTEXT--------------------
  (if (not (null? L))
  ;--------------------------- 
      
      (call/cc (lambda(cont)
                 (if (cond (car L))
                     (set! queue (append queue (list cont)));FIFO queue. NOT A STACK.
                     )
               (body (car L)) );for-each/cc will call this on every value BUT 
                               ;when we will call each saved cont, there the context is switched, the value on which we set! the cont in the gloabal queue is discarded.
                               ;We will resume computations starting from the recursive call, so the current value is discarded and not displayed.
       )
     )

  ;OTHER PART OF CONTEXT------
  (for-each/cc cond (cdr L) body) )
  

;ANOTHER SOLUTION:--------------------------------------------------------------------------------------------------------


;global queue
(define cont '())

;extract and call the last procedure
(define (use-cc)
  (let ((c (car cont)))
    (set! cont (cdr cont))    
  (c))
  )

;input: cond, L, body
(define (for-each/cc cond L body)
  (for-each (lambda(x)
              
              (call/cc (lambda(c) ;chiama qui la continuation
                      (when (cond x)
                           (if (empty? cont)
                               (set! cont (list c))
                               (set! cont (append cont (list c))) )
                                     ) (body x) ) ;passare paramentro a body
                           )) 

                       L)
 )

(for-each/cc odd?  '(1 2 3 4)  (lambda (x) (displayln x)))

;Then, if we run: (use-scc), we will get on screen:
;2
;3
;4
(newline)
(use-cc) 
(newline)
(use-cc) 


