#lang racket

;Write a functional, tail recursive implementation of a procedure that takes a list of numbers L and two values
;x and y, and returns three lists: one containing all the elements that are less than both x and y, the second one
;containing all the elements in the range [x,y], the third one with all the elements bigger than both x and y. It
;is not possible to use the named let construct in the implementation.

;SOL:

(define (3-part L v1 v2)
  
  (define (3-p L v1 v2 r1 r2 r3)
    (if (null? L)
        (list r1 r2 r3)
        (let ((x (car L)) ;named let means we cannot use the let to create a loop, like: let loop ((var val))
              (xs (cdr L)))
          (cond
            ((and (< x v1)(< x v2)) (3-p xs v1 v2 (cons x r1) r2 r3))
            ((and (>= x v1)(<= x v2)) (3-p xs v1 v2 r1 (cons x r2) r3))
            ((and (> x v1)(> x v2)) (3-p xs v1 v2 r1 r2 (cons x r3)))))))
  
  (3-p L v1 v2 '() '() '()) ;last call
  )

(3-part '(1 2 2 3 5 7 7 8 9) '2 '4)


;this one below is not tail-recursive because the recursive call was part of a cond expression, 
;and there are additional expressions to evaluate after the recursive call. In a tail-recursive function, 
;the recursive call should be the last operation in the function as above.

(define L1 '())
(define L2 '())
(define L3 '())

(define (tail-procedure L x y)
  (if (null? L)
      ;base case
      (cons L1 (cons L2 (list L3)))
      ;else
      (cond
        ((and (> (car L) x) (> (car L) y)) (set! L1 (cons (car L) L1) ) (tail-procedure (cdr L) x y) ) 
        ((and (>= (car L) x) (<= (car L) y)) (set! L2 (cons (car L) L2) ) (tail-procedure (cdr L) x y) ) 
        ((and (< (car L) x) (< (car L) y)) (set! L3 (cons (car L) L3) ) (tail-procedure (cdr L) x y) ) 
        )
                            
      )
  )


(tail-procedure '(1 2 2 3 5 7 7 8 9) '2 '4)
;(5 7 7 8 9)
;(2 2 3)
;(1)
