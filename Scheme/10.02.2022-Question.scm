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

Define function r with a variable number of inputs.
If s is a cons node then set s to the first element of the cons node, otherwise set it to 1.
then define an anonymous procedure that if x<y z=x, sets x=x+s and returns z, otherwise returns y.
The lambda has the purpose of creating a closure.

(r 1 2 3)
;1


;2. It makes sense to create a version of r without the y parameter? If the answer is yes, implement
;such version; if no, explain why.

I would say so, since y is a max value just drop it and return elements

(define (r1 x . s)
 (set! s (if (cons? s) (car s) 1))
 (lambda ()
 (let ((z x))
 (set! x (+ s x))
 z)))

