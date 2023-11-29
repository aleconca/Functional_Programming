#lang racket

;Define a construct variant of call/cc, called call/cc-store, with syntax:

;(call/cc-store (k in v) e1 ...)

;where k is the current continuation, v is a visible variable in the current
;scope, and e1 ... is the body of the construct. The semantics is the same of the
;usual call/cc (with a simplified syntax, not requiring a lambda), but the
;current continuation must also be stored in v, before executing the body.



(define-syntax call/cc-store
  (syntax-rules (in)
    ((_ (k in v) e ... )
     (call/cc (lambda (k)
               (set! v k) 
                e ...)
              )
     )
    )
  )


;WRONG:

;(define-syntax call/cc-store
  ;(syntax-rules(in)
    ;((_ (k in v) body ...)
     ;(let ( (v (call/cc(lambda(k) k))) ) ;call the cc ->wrong, I want to save it in v
       ;body ...
       ;)
     ;)
    ;)
  ;)
