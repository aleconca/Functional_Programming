#lang racket

;Define in a purely functional way a procedure called revlt, which takes three lists, (x1 ... xL) (y1 ... yM) (z1 .. zN)
;and returns the list of vectors: (#(xO yO zO) ... #(x1 y1 z1)), where O ≥ 1 is the smallest among L, M, and N.

;E.g. (revlt '(1 2 3) '(4 5 6 7) '(8 9 10)) is the list '(#(3 6 10) #(2 5 9) #(1 4 8)).
