#lang racket

;Consider a procedure p that receives as input a list. Elements in the list are either numbers or strings, together with the two special
;separators * and $.

;For instance, L = (* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $).

;Implement p as a tail recursive function that sums all the numbers found between two occurrences of * symbols, and concatenates
;all the strings between occurrences of $, then returns the list of the resulting elements. Numbers and strings that are not between
;the correct pair of separators are discarded.

;E.g., in the case of L, the result should be (6 1 3 “hellomyworld”)


;SOL

(define (loc-p ls res cint cstr)
  
   (if (null? ls)
        res
       (let ((cur (car ls)))
         (cond
          ((eq? cur '*)
              (if cint
                 (loc-p (cdr ls) (append res (list cint)) #f cstr)
                 (loc-p (cdr ls) res 0 cstr)))
          ((eq? cur '$)
              (if cstr
                 (loc-p (cdr ls) (append res (list cstr)) cint #f)
                 (loc-p (cdr ls) res cint "")))
          
          ((and cint (number? cur))
                 (loc-p (cdr ls) res (+ cur cint) cstr))
          ((or (and cstr (string? cur)) (eq? cstr "") (and cstr (not (number? cur))))
           (loc-p (cdr ls) res cint (append (list cstr) (list cur))))
          (else
                 (loc-p (cdr ls) res cint cstr))
          )
       )
       )
  )

(define (p lst)
 (loc-p lst '() #f #f))

(p '(* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $))
