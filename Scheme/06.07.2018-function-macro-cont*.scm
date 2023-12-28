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

;1)
(define (deepen L)
  (foldl (lambda(x y)(list y x)) (list (car L)) (cdr L)) ;not cons in lambda: '(((((((x1) . x2) . x3) . x4) . x5) . x6) . x7)
  )
(deepen '(x1 x2 x3 x4 x5 x6 x7))
;'(((((((x1) x2) x3) x4) x5) x6) x7)

;2)
(define-syntax define-with-return:
  (syntax-rules()
    ((_ return (f x ...) body ...)
     (define (f x ...) 
       (call/cc (lambda(return) body ...)) ;when you will call the lambda from the body you will get that the lambda will be evaluated as: 
                                           ;(lambda(return) (return value) )
       )                                   ;same as we did in the example (exit #f)
     )
    )
  )


(define-with-return: return (f x)
  (define a 12)
  (return (+ x a))
  'unreachable)

(f 3)

