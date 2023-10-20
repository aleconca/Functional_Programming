#lang racket

;Define a pure function multi-merge with a variable number of arguments (all of them must be ordered lists of
;numbers), that returns an ordered list of all the elements passed. It is forbidden to use external sort functions.
;E.g. when called like:
;(multi-merge '(1 2 3 4 8) '(-1 5 6 7) '(0 3 8) '(9 10 12))
;it returns: '(-1 0 1 2 3 3 4 5 6 7 8 8 9 10 12)
