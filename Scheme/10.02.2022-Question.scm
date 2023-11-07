;Consider the following code:

;(define (r x y . s)
 ;(set! s (if (cons? s) 
             ;(car s) 
             ;1))
 ;(lambda ()
     ;(if (< x y)
         ;(let ((z x))
           ;(set! x (+ s x))
            ;z)
         ;y)
   ;)
 ;)
 
;1. What can we use r for? Describe how it works and give some useful examples of its usage.

;The lambda allows us to save the context sorrounding it; thus: s,x,y.
;Each new call uses the saved local parameters from the previous call.
;Updates end once x>y.
;It is a generator implemented as a closure, which returns the numbers from x to y with step s (+1 if s is not defined). When y
;is reached, it returns it indefinitely.


;2. It makes sense to create a version of r without the y parameter? If the answer is so, implement
;such version; if no, explain why.

;Yes, we can eliminate y.

(define (r x y . s)
 (set! s (if (cons? s) 
             (car s) 
             1))
 (lambda ()
     (let ((z x))
         (set! x (+ s x))
            z)
         )
 )

(define (r1 x . s)
 (set! s (if (cons? s) (car s) 1))
 (lambda ()
 (let ((z x))
 (set! x (+ s x))
 z)))

