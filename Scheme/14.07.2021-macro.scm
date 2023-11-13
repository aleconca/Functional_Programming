#lang racket

;Define a defun construct like in Common Lisp, where (defun f (x1 x2 ...) body) is used for defining a
;function f with parameters x1 x2 ....

;Every function defined in this way should also be able to return a value x by calling (ret x).


(define ret-store '())

(define (ret v)
  ((car ret-store) v));why not an apply?

;define contruct
(define-syntax defun
  (syntax-rules ()
    ;define pattern to match
    ((_ fname (var ...) body ...)
     ;define behaviour, perchè no begin?
     (define (fname var ...)
       (let ((out ;CONTEXT up--------------------------------------
                  (call/cc (lambda (c)
                             (set! ret-store (cons c ret-store))
                             body ...))
                   ));down------------------------------------------
         (set! ret-store (cdr ret-store))
         out)))))

;when we save the continuation, we are saving the context, i.e. the definition of the function, the variable out containig 
;the evaluation of the body and the set!.

;If we will decide to call (ret x), then we will resume computation from the saved context. What we will obtain is 
;an evaluation of the body in any case as the out variable contains it, despite the fact that we are discarding the car of ret-store.

;ret-store is called like this because we are indeed saving return values.

;N.B. by puttng body in the lambda we are evaluating it already.

;Could have I done it like this?




