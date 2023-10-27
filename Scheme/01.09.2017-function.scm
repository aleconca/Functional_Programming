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


;CORRECTED SOL:

(define (check-this L)
  
   ;definre variabili per valori di ritorno intero della helper function ricorsiva che controlla valore positivo o negativo-> se negativo ritorna falso senza sommare
   ;es. 6 h a a 1 2 2 b
   ;input: #ab , #12, res, L
   (define (helper countab count12 res L)
     
     (if (or (< countab 0)(< count12 0))
         #f
 
     ;else
         (if (null? L)
             res

             ;else
             (let ((head (car L)) (rest (cdr L)))
 
               (cond
                 ((eq? head 'a) ( (helper (+ countab 1) count12 res rest) ))
                 ((eq? head 'b) ( (helper (- countab 1) count12 (+ res 1) rest) ))
                 ((eq? head 1) ( (helper countab (+ count12 1) res rest) ))
                 ((eq? head 2) ( (helper countab (- count12 1) (+ res 1) rest) ))
                 )
               )
         )

     )
     )
  (helper 0 0 0 L)
  )



;THIS CODE DOESN'T WORK: should find a way to do it without cdr and car since we end up passing void lists to such structure which yields an error->(cdr '()) stop 1 iter 

; Define a tail-recursive helper function
 (define (count-xy x y z w res L)(
    ; Remember the previous balance in w
    (set! w z)
    
    (cond
      ((empty? L) ; End of the list
       (if (= z 0) ; All matched parenthesis
           res
           #f))
      ((< z 0) #f) ; Unmatched parenthesis, return false
      ((eq? (car L) x) ; Check for open symbols (a and 1)
       (set! z (+ z 1)))
      ((eq? (car L) y) ; Check for close symbols (b and 2)
       (set! z (- z 1)))
       ; Default case
    )
    
    ; If balance from this iteration has decreased, then we matched a pair
    ((if (< z w) 
        (count-xy x y z w (+ res 1) (cdr L))
        (count-xy x y z w res (cdr L)))
        
    
  )
 )
)



 
(define (check-this L iter )
(
  
  ;Initialize counts for 'a' and 'b' as well as '1' and '2'
  (let ((ab (count-xy 'a 'b 0 0 0 L))
        (onetwo (count-xy 1 2 0 0 0 L)))
  ; Return the sum of both counts
  (+ ab onetwo)
   )

)
)

(display (check-this '(a b a b) )) ; Output: 2 OK
(display (check-this '(h e l l o) )) ; Output: 0 OK
(display (check-this '(6 h a b a 1 h h i 2 b z 1))) ; Output: 3 KO
(display (check-this '(6 h a b a 1 h h i b z 2) )) ; Output: #f (wrong structure) KO
             
    


