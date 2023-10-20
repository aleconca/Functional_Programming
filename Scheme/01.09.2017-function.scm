#lang racket

;Consider a list L of symbols. We want to check if in L there are matching “a” and “b” symbols or “1” and “2” symbols, where “a”
;and “1” have an open parenthesis role, while “b” and “2” stand for close parenthesis respectively (i.e. a Dyck language); other
;symbols are ignored. Define a pure and tail recursive function check-this which returns the number of matching pairs, and #f if the
;parenthesis structure is not respected.

;E.g.
;(check-this '(a b a b)) is 2
;(check-this '(h e l l o)) is 0
;(check-this '(6 h a b a 1 h h i 2 b z)) is 3
;(check-this '(6 h a b a 1 h h i b z 2)) is #f (wrong structure)
