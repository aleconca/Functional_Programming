#lang racket

;Implement this new construct: (each-until var in list until pred : body), where keywords are written in
;boldface. It works like a for-each with variable var, but it can end before finishing all the elements of list
;when the predicate pred on var becomes true.

;E.g.
;(each-until x in '(1 2 3 4)
  ;until (> x 3) :
  ;(display (* x 3))
  ;(display " "))

;shows on the screen: 3 6 9
