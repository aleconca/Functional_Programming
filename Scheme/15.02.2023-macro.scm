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



 (define saved-cont '())

(define-syntax break
  (syntax-rules ()
    ((_ e ...)
     (let ((c (car saved-cont)))
       (set! saved-cont (cdr saved-cont))
       (c #f)))
     )
  )

(define-syntax For
 (syntax-rules (from to break do)
 ((_ var from min to max break do body ...)
  (let* ((min1 min)(max1 max)(inc (if (< min1 max1) + -))) 
       (call/cc (lambda (cont)
                   (let loop ((var min1))
                     (if (var < max1)
                         ((set! saved-cont (cons cont saved-cont))
                           body ...)
                          break )
                       (loop (inc var 1)))))
    ))))


(define-syntax For
 (syntax-rules (from to break do)
 ((_ var from min to max do body ...)
  (let* ((min1 min)(max1 max)(inc (if (< min1 max1) + -))) 
       (call/cc (lambda (break)
                   (let loop ((var min1))
                     (if (var < max1)
                          (body ...)
                          (break #f)
                       (loop (inc var 1)))))
    ))))
