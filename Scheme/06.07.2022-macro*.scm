#lang racket

;Consider the technique “closures as objects” as seen in class, where a closure assumes the role of a class.
;In this technique, the called procedure (which works like a class in OOP) returns a closure which is
;essentially the dispatcher of the object.

;Define the define-dispatcher macro for generating the dispatcher in an automatic way, as illustrated by
;the following example:

;(define (make-man)
; (let ((p (make-entity))
; (name "man"))
; (define prefix+name
; (lambda (prefix)
; (string-append prefix name)))
; (define change-name
; (lambda (new-name)
; (set! name new-name)))
; (define-dispatcher methods: (prefix+name change-name) parent: p)))

;where p is the parent of the current instance of class man, and make-entity is its constructor.
;If there is no inheritance (or it is a base class), define-dispatcher can be used without the parent: p part.

;Then, an instance of class man can be created and its methods can be called as follows:
;> (define carlo (make-man))
;> (carlo 'change-name "Carlo")
;> (carlo 'prefix+name "Mr. ")
;"Mr. Carlo"


(define (unknown-method ls)
  (error "Unknown method" (car ls)))
  

(define-syntax define-dispatcher
  (syntax-rules (methods: parent:)
    
    ((_ methods: (mt ...) parent: p)
     (lambda (message . args)
       (case message
         ((mt) (apply mt args))
         ...
         (else (apply p (cons message args))))))
    
    ((_ methods: mts)
     (define-dispatcher methods: mts parent: unknown-method)))
  )



(define (make-man)
  (let ((p (make-entity))
        (name "man"))
    (define prefix+name
      (lambda (prefix)
        (string-append prefix name)))
    (define change-name
      (lambda (new-name)
        (set! name new-name)))
    (define-dispatcher methods: (prefix+name change-name) parent: p)))


(define carlo (make-man))
(carlo 'change-name "Carlo")
(carlo 'prefix+name "Mr. ")



