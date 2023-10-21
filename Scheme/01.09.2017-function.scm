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


(define (check-this L)

;define parametric tail-recursive function
;- x,y : parameters to match
;- z : balance
;- w : oldbalance
;- res : accumulated result  
  
(define (count-xy x y z w res L)


;wrong structure ex. ba   
((if (< z 0) 
      #f));end with error
  
(if (null? L) ;end of list
    ((if (= z 0);all matched parenthesis 
          res ;end fine
          #f));end with errors
)

;remember previous balance in w
(set! w z)
  
;parametrized cases:
;cond works by searching through its arguments in order. It finds the first argument whose first element returns #t when evaluated, 
;and then evaluates and returns the second element of that argument. It does not go on to evaluate the rest of its arguments.
;Make sure that the last argument to every cond statement will always accept anything. This is important for avoiding infinite loops.
  (cond         
                 
                 ;check structure: ab aabbb bbaa
                 ( (eq? (car L) x)  (set! z (+ z 1)) ) ;check a and 1
                 
                 ( (eq? (car L) y)  (set! z (- z 1))) ;check b and 2

                 (else (set! (= z z)));default

                 )
  ;if balance from this iteration has decreased then we have matched an ab in the cond
  (if (and (< z w) (> z 0));z must be positive otherwise a string starting with b would +1 result
      (count-xy x y z w (+ res 1) (cdr L))
      (count-xy x y z w res (cdr L))
  )
  )
  
  (let (ab (count 'a 'b 0 0 0 L)))
  (let (onetwo (count 1 2 0 0 0 L)))

  ((+ ab onetwo)) ) 
             
  
  


