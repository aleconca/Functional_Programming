#lang racket

;We want to implement a version of call/cc, called store-cc, where the continuation is called only once and
;it is implicit, i.e. we do not need to pass a variable to the construct to store it. Instead, to run the
;continuation, we can use the associated construct run-cc (which may take parameters). The composition
;of store-cc must be managed using in the standard last-in-first-out approach.

(define saved-cont '())

(define (run-cc . param)
  (let (c (car saved-cont))
    (set! saved-cont (cdr saved-cont))
    (apply c param)
    )
  )

(define-syntax store-cc
  (syntax-rules()
    ((_ e ...)
       (call/cc (lambda(x) (set! saved-cc (cons (list x)(saved-cont)))) )
         e...))
  )


;N.B.
;(append c cont) and (set! cont (cons (list c) cont)  do the same thing?

;(append c cont): This expression appends the element c to the list cont. 
;The append function typically creates a new list that is the result of appending the element c to the end of the existing list cont. 
;The original list cont remains unchanged, and a new list is returned.

;(set! cont (cons (list c) cont)): This expression modifies the variable cont in-place by prepending a new list containing the element c to the existing list cont. 
;The cons function creates a new pair with the element c and the existing list cont, and then set! is used to update the variable cont with the new pair.

