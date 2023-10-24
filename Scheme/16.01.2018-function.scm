#lang racket

;Consider a procedure p that receives as input a list. Elements in the list are either numbers or strings, together with the two special
;separators * and $.

;For instance, L = (* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $).

;Implement p as a tail recursive function that sums all the numbers found between two occurrences of * symbols, and concatenates
;all the strings between occurrences of $, then returns the list of the resulting elements. Numbers and strings that are not between
;the correct pair of separators are discarded.

;E.g., in the case of L, the result should be (6 1 3 “hellomyworld”)
