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

;global queue
(define cont '())

;extract and call the last procedure
(define (use-cc)
  (let ((c (car cont)))
    (set! cont (cdr cont))    
  c)
  )

;input: cond, L, body
(define (for-each/cc cond L body)
  (for-each (lambda(x)
                      (when(cond x)
                        
                           (call/cc (lambda(c)
                                      (if (empty? cont)
                                          (set! cont (list c))
                                          (set! cont (cons c  cont)) )
                                     body))
                           ) )

                       L)
 )

(for-each/cc odd?  '(1 2 3 4)  (lambda (x) (displayln x)))
(display cont)
(newline)
(use-cc)
(display cont)

