#lang racket


;Write a function, called fold-left-right, that computes both fold-left and fold-right, returning them in a pair. Very
;important: the implementation must be one-pass, for efficiency reasons, i.e. it must consider each element of the
;input list only once; hence it is not correct to just call Scheme’s fold-left and -right.
;Example: (fold-left-right string-append "" '("a" "b" "c")) is the pair ("cba" . "abc").


(define (fold-left-right f i l)
  ; Define the fold-left-right function that takes three arguments:
  ; f - a binary function to be applied to the elements
  ; i - the initial value for folding
  ; l - the list to be folded
  
  (let loop ((left i) (right (lambda (x) x))  (xs l))        
    
    (if (null? xs)            
        (cons left (right i)) 
                              
      (loop (f (car xs) left)  (lambda (x) (right (f (car xs) x)))  (cdr xs)))))    


(fold-left-right string-append  ""  '("a" "b" "c") )
;'("cba" . "abc")




