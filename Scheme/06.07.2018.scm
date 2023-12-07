#lang racket

;1) Give a purely functional definition of deepen, which takes a list (x1 x2 ... xn) and returns ((... ((x1) x2) ...) xn).

;2) Write the construct define-with-return:, which takes a name m, used as a return function, a list function name + parameters, and
;a function body, and defines a function with the same characteristics, where calls to m are used to return a value.

;E.g. if we define
;(define-with-return: return (f x) ; note that the function name is f, while return is used, of course, for returning
;(define a 12)
;(return (+ x a))
;'unreachable),
;a call (f 3) should give 15.
