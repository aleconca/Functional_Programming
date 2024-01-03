#lang racket

;Define the construct define-with-types, that is used to define a procedure with type constraints, both for the parameters and for the return value. The type constraints are the corresponding type predicates, e.g. number? to check if a value is a number.
;If the type constraints are violated, an error should be issued.

;E.g.
;(define-with-types (add-to-char : integer? (x : integer?) (y : char?))
  ;(+ x (char->integer y)))
;defines a procedure called add-to-char, which takes an integer and a character, and returns an integer.
