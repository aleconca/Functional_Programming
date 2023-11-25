#lang racket

;Define a construct variant of call/cc, called call/cc-store, with syntax:

;(call/cc-store (k in v) e1 ...)

;where k is the current continuation, v is a visible variable in the current
;scope, and e1 ... is the body of the construct. The semantics is the same of the
;usual call/cc (with a simplified syntax, not requiring a lambda), but the
;current continuation must also be stored in v, before executing the body.

