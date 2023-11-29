#lang racket

;Define the verbose construct for folding illustrated by the following
;example:

;(cobol-fold direction -> from 1 data 1 2 3 4 5 6
            ;(exec
             ;(displayln y)
             ;(+ x y))
             ;using x y)        
                               
;This is a fold-right (->) with initial value 1 on the list (1 2 3 4 5
;6), and the fold function is given in the "exec" part.  Of course, <-
;is used to select fold-left instead of right.


(define-syntax cobol-fold
  (syntax-rules(direction -> <- from data exec using)
    ((_ direction -> from i data val ... (exec body ...) using x y)
     (foldr (lambda (x y) body ...) i '(val ...)) ;use a lambda because you cannot define a function in a macro (?)
     )
    ((_ direction <- from i data val ... (exec body ...) using x y)
     (foldl (lambda (x y) body ...) i '(val ...))
     )
    )
  )

(cobol-fold direction <- from 1 data 1 2 3 4 5 6
            (exec
             (displayln y)
             (+ x y))
             using x y)
