#lang racket

;Consider the following code:

;(define (a-function lst sep)
  ;(foldl (lambda (el next)
          ;(if (eq? el sep) (cons '() next)
                           ;(cons (cons el (car next)) (cdr next)))
          ;) (list '()) lst)
  ;)

;1) Describe what this function does; what is the result of the following call?
;(a-function '(1 2 nop 3 4 nop 5 6 7 nop nop 9 9 9) 'nop)

;2) Modify a-function so that in the example call the symbols nop are not discarded from the resulting list,
;which must also be reversed (of course, without using reverse).
