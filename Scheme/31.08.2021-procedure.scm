#lang racket


;1) Define a procedure which takes a natural number n and a default value, and creates a n by n matrix
;filled with the default value, implemented through vectors (i.e. a vector of vectors).
;2) Let S = {0, 1, ..., n-1} x {0, 1, ..., n-1} for a natural number n. Consider a n by n matrix M, stored in a
;vector of vectors, containing pairs (x,y) ∈ S, as a function from S to S (e.g. f(2,3) = (1,0) is represented
;by M[2][3] = (1,0)). Define a procedure to check if M defines a bijection (i.e. a function that is both 
