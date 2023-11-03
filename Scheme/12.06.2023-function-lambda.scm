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
  
  (let loop ((left i)          ; Define a nested function 'loop' with parameters:
             (right (lambda (x) x)) ; Initialize 'right' as an identity function
             (xs l))          ; Initialize 'xs' with the input list 'l'
    ; This is a tail-recursive loop that will iterate through the list 'l'.
  
    (if (null? xs)            ; If we have reached the end of the list:
        (cons left (right i)) ; Return a cons node where 'left' is the result of fold-left
                              ; and 'right' is the result of fold-right.
      (loop (f (car xs) left) ; Apply the binary function 'f' to the head of the list and 'left'
            (lambda (x)       ; Define a lambda function that takes 'x' as a parameter:
              (right (f (car xs) x))) ; Apply 'f' to the head of the list and the result 'x' for 'right'
            (cdr xs)))))     ; Move to the next element of the list by taking the cdr.



;NO LAMBDA:-------------------------------------------------------------------------------------------------


;fold-left-right takes as input a binary function, the accumulator and a list.
(define (fold-left-right f acc L)
  (if (null? L)
      acc
      (if (eq? acc "")
          (let ((pair  (cons (car L) (car L))))
          (fold-left-right f pair (cdr L)))
          (fold-left-right f 
            (cons (car L) (append (list acc) (list (car L)))) (cdr L))  
       )
  )
  )


(fold-left-right string-append  ""  '("a" "b" "c") )
;is the pair ("cba" . "abc")
;'("c" ("b" ("a" . "a") "b") "c")




