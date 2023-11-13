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
    ((_ condition body ...)
     (when condition
       (call/cc (lambda(x) (set! saved-cc (cons (list x)(saved-cont))) ))
       (begin
         body...))))
  )

;cosa significa fare apply tra una continuation e un parametro?
;perchè posso definire semplicemente (_ e ...) senza una condizione da verificare? Quell' 'e' corrisponde ad un body?
;cosa posso/devo mettere nel (syntax-rules()( ))?
;perchè in questo caso posso salvare direttamente il cons senza convertire in lista?
