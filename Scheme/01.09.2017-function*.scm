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



;------------------------------------------

(define (helper L x y flagx flagy)
  (if (null? L)
      (if (and (= flagx 0)(= flagy 0))
          (+ x y)
          (display '#f)
          )
      (let ((curr (car L)))
        (cond
            ((eq? curr 'a) (helper (cdr L) x y (+ flagx 1) flagy))
            ((eq? curr '1) (helper (cdr L) x y flagx (+ flagy 1)))
            ((and (eq? curr 'b)(>= flagx 1)(< flagy flagx)) (helper (cdr L) (+ x 1) y (- flagx 1) flagy))
            ((and (eq? curr '2)(>= flagy 1)) (helper (cdr L) x (+ y 1) flagx (- flagy 1)))
            (else (helper (cdr L) x y flagx flagy))
          )))
  )

(define (check-this L)
  (helper L 0 0 0 0)
  )

(check-this '(a b a b))
(check-this '(h e l l o))
(check-this '(6 h a b a 1 h h i 2 b z))
(check-this '(6 h a b a 1 h h i b z 2))
(check-this '(a a b b a 1 b 2))
