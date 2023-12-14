#lang racket

;Consider a procedure p that receives as input a list. Elements in the list are either numbers or strings, together with the two special
;separators * and $.

;For instance, L = (* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $).

;Implement p as a tail recursive function that sums all the numbers found between two occurrences of * symbols, and concatenates
;all the strings between occurrences of $, then returns the list of the resulting elements. Numbers and strings that are not between
;the correct pair of separators are discarded.

;E.g., in the case of L, the result should be (6 1 3 “hellomyworld”).



(define (p lst)
  
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
            ((and cstr (string? cur))
             (loc-p (cdr ls) res cint (string-append cstr cur)))
            (else
             (loc-p (cdr ls) res cint cstr))
            ))))
  
  (loc-p lst '() #f #f))




(define (helper L x y num string res1 res2 flag1 flag2)
  (if (null? L)
      (if (and (even? flag1)(even? flag2))
          (cons res1 res2)
          (display "error"))
      (let ((curr (car L)))
        (cond ((eq? curr x) ((set! flag1 (+ flag1 1)) (cond ((= flag1 1) (helper (cdr L) x y num string res1 res2 flag1 flag2))
                                                            ((> flag1 1) ((set! flag1 0) (append num (list res1)) ))  ) ) )
              ((eq? curr y) ((set! flag2 (+ flag2 1)) (if (= flag2 1) (helper (cdr L) x y num string res1 res2 flag1 flag2)
                                                          ((set! flag2 0) (append res2 string))) ) )
              ((and (odd? flag1) (number? curr) ) (helper (cdr L) x y num string (+ curr res1) res2 flag1 flag2) )
              ((and (odd? flag2)(string? curr)) (helper (cdr L) x y num string res1 (string-append (list curr) res2) flag1 flag2)) )
      )
      )
  )



(define (p L)
  (helper L '* '$ '() '() 0 '() 0 0)
  )


(p '(* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $))
;(6 1 3 “hellomyworld”)
