#lang racket

;Define in a purely functional way a procedure called revlt, which takes three lists, (x1 ... xL) (y1 ... yM) (z1 .. zN)
;and returns the list of vectors: (#(xO yO zO) ... #(x1 y1 z1)), where O ≥ 1 is the smallest among L, M, and N.

;E.g. (revlt '(1 2 3) '(4 5 6 7) '(8 9 10)) is the list '(#(3 6 10) #(2 5 9) #(1 4 8)).

(define (revlt L1 L2 L3)
  (let ((O 0)(concat (cons L1 (cons L2 (list L3)))) )
    
    (cond
      ((and (length L1)<(length L2) (length L1)<(length L3)) (set! O (length L1)))
      ((and (length L2)<(length L1) (length L2)<(length L3)) (set! O (length L2)))
      ((and (length L3)<(length L1) (length L3)<(length L2)) (set! O (length L3)))
      )
    
    (let loop ((i O) (j 0) (k 0) (L '()) (v1 (make-vector O)) (v2 (make-vector O)) (v3 (make-vector O)) )
      
      (when (> i 0)
        
        (set! L (list-ref concat j))
        
        (vector-set! v1 j  (list-ref L k)) 
        (vector-set! v2 j (list-ref L (+ k 1))) 
        (vector-set! v3 j (list-ref L (+ k 2)))

        (loop (- i 1) (+ j 1) k L v1 v2 v3)
        )
      
      (foldl cons '() (list v1 v2 v3))
      
      )
    
    )
  )
  

(revlt '(1 2 3) '(4 5 6 7) '(8 9 10))
;'(#(3 6 10) #(2 5 9) #(1 4 8))
