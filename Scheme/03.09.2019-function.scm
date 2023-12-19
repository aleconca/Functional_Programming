#lang racket

;Consider the following code:

(define (a-function lst sep)
  (foldl (lambda (el next)
          (if (eq? el sep) (cons '() next)
                           (cons (cons el (car next)) (cdr next))) ;usa la lista vuota creata da nop precedente per inserire valori successivi
          ) (list '()) lst)
  )

;1) Describe what this function does; what is the result of the following call?
;(a-function '(1 2 nop 3 4 nop 5 6 7 nop nop 9 9 9) 'nop)

;2) Modify a-function so that in the example call the symbols nop are not discarded from the resulting list,
;which must also be reversed (of course, without using reverse).


;1)
;a-function executes a fold left, which takes as input:
;a binary function, i.e. a lambda, an empty list as accumulator, the input list lst.
;The lambda takes an element from lst and the accumulator containing intermediate computations, if element is equal to the input value sep,
;it creates a cons node containing the next element;
;otherwise, it creates a cons node having as car (cons el (car next)) and as cdr the next. The first list is used to discard the nops, the second for the final result.
;fold left inverts the ordering of the elements and erases the nops:
;'((9 9 9) () (7 6 5) (4 3) (2 1))
;each nop implements a separator.

;2)
(define (a-function1 lst sep)
  (foldl (lambda (el next)
          (if (eq? el sep) (cons (list el) next) ;create nop list
                           (cons (cons el (car next)) (cdr next))) ;append elements until a new nop is found and thus a new sublist created
          ) (list '()) lst)
  )

(a-function1 '(1 2 nop 3 4 nop 5 6 7 nop nop 9 9 9) 'nop)
;'((9 9 9 nop) (nop) (7 6 5 nop) (4 3 nop) (2 1))
