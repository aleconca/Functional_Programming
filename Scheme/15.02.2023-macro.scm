#lang racket

;Consider the following For construct, as defined in class:

;(define-syntax For
 ;(syntax-rules (from to break: do)
 ;((_ var from min to max break: break-sym
 ;do body ...)
 ;(let* ((min1 min)
 ;(max1 max)
 ;(inc (if (< min1 max1) + -)))
 ;(call/cc (lambda (break-sym)
 ;(let loop ((var min1))
 ;body ...
 ;(unless (= var max1)
 ;(loop (inc var 1))))))))))

 ;Define a fix to the above definition, to avoid to introduce in the macro definition the special break symbol breaksym, by providing a construct called break. E.g.
;(For i from 1 to 10
; do
 ;(displayln i)
 ;(when (= i 5)
 ;(break #t)))
 ;will return #t after displaying the numbers from 1 to 5.



(define exit-store '())

(define (break v)
  ((car exit-store) v))

(define-syntax For+
  (syntax-rules (from to do)
    ((_ var from min to max do body ...)
     
     (let* ((min1 min)
            (max1 max)
            (inc (if (< min1 max1) + -)))
       
       (let ((v (call/cc (lambda (break)
                           (set! exit-store (cons break exit-store))
                           (let loop ((var min1))
                             body ... ;nel body ci sarà (break #t)
                             (unless (= var max1)
                               (loop (inc var 1))))))
                ))
         ;(set! exit-store (cdr exit-store)); l'ho usato
         v)

       ))))


(For+ i from 1 to 10
 do
 (displayln i)
  (when (= i 5)
   (break #t))) ; nel momento in cui i=5 sostituisco il loop con #t, quindi v sarà uguale a true e ritorno true




;Could have I done like this?

;1) Works fine.
(define saved-cont '())

(define (break v)
(let ((c (car saved-cont)))
       (set! saved-cont (cdr saved-cont))
       (c v)))
     
  

(define-syntax For
 (syntax-rules (from to break do)
 ((_ var from min to max do body ...)
  (let* ((min1 min)(max1 max)(inc (if (< min1 max1) + -))) 
       (call/cc (lambda (cont)
                   (set! saved-cont (cons cont saved-cont))
                   (let loop ((var min1))
                             body ...
                           (unless (= var max1)
                       (loop (inc var 1)))
                      )) )
    ))))


(For i from 1 to 10
 do
 (displayln i)
  (when (= i 5)
   (break #t) ))






;2)NO, the continuation is called externally by the body, we need to save the context and then call it.

(define-syntax For
 (syntax-rules (from to break do)
 ((_ var from min to max break do body ...)
  (let* ((min1 min)(max1 max)(inc (if (< min1 max1) + -))) 
       (call/cc (lambda (break-sym)
                   (let loop ((var min1))
                             body ...
                           (unless (= var max1)
                       (loop (inc var 1)))
                     (break #f) )))
    ))))
