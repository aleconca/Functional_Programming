#lang racket


;Write a function, called fold-left-right, that computes both fold-left and fold-right, returning them in a pair. Very
;important: the implementation must be one-pass, for efficiency reasons, i.e. it must consider each element of the
;input list only once; hence it is not correct to just call Scheme’s fold-left and -right.
;Example: (fold-left-right string-append "" '("a" "b" "c")) is the pair ("cba" . "abc").


;we need to create a cons node where the car contains the fold-left and the cdr contains the fold-right

(define (fold-left-right  f L) )

