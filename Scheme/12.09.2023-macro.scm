#lang racket

;1. Design a construct to define multiple functions with the same number of arguments at the same time. The
;proposed syntax is the following:
;(multifun <list of function names> <list of parameters> <list of bodies>).
;E.g. (multifun (f g) (x)
 ;((+ x x x)
 ;(* x x)))
;defines the two functions f with body (+ x x x) and g with body (* x x), respectively.


;SOL:

;my solution involves macros since we want to define a new keyword, something
;similar to what we did in class with the while construct.

;Hypothesis: we do have more than 1 function and more than 1 body and
;the goal is just defining functions so we do not need to care about ret values 
;in the begin block[*]

(define-syntax multifun
  (syntax-rules () ;no additional syntax to pass to the constrct

    ;remember that recursion needs a base case
    ((_ (f) (x ...) (b))
      (define (f (x ...)) b))
  
    ;we need to match a list of fs, list of params and bodies
    ;so we use (f . rest1) which is a way to define a list with a cons 
    ;node but which highlights the first element (f, the car) and the remaining ones (rest1, the cdr);
    ;we do this for functions and bodies.
    ; _ matches multifun keyword.
    ;as parameters are the same list for each one I write (x ...) which means 
    ;'one or more parameter'
    ((_ (f . rest1) (x ...) (b . rest3) )
    
      ;why a begin?[*]
      (begin 
      
      ;now we need to define a way to apply functions and bodies
      ;f is alraedy defined so we only need to apply it to the params and match it with its body
      (define (f (x ...)) 
      
              ;define the respective body
              b)  
      
      ;since we have more than one f we make the macro recursive->tail-recursive call
      (multifun rest1 (x ...) rest3)
      
      )
      
       )))              


;[*] remember begin is used for such cases:
;The syntax of the begin construct is as follows:

;(begin
  ;expression1
  ;expression2
  ;...
  ;expressionN)
  
;expression1, expression2, ..., expressionN: 
;These are the expressions that you want to evaluate sequentially. 
;Each expression can be any valid Scheme expression.
;begin can return 1 value.





;Would be possible to define something similar, but using a procedure and lambda functions instead of a
;macro? If yes, do it; if no, explain why.

;SOL

;Of course we can use a list of lambda functions instead of the list of bodies (alas, we need to replicate the list of
;parameters on each body). The main problem is that we cannot bind the top-level function names from inside a procedure, so the
;answer is no.



;MINE:

(define (multifun (f . rest1) (x ...) (b . rest2))
  
  (begin

   ;define the anonymous procedure using a lambda function
   (define f (lambda(x ...) (b)))
   
   ;make it tail recursive
   (multifun rest1 (x ...) rest3) 
  
  )
  )


;WRONG!! why?

;Rebinding of f: trying to redefine f within the lambda, which is not allowed.

;Recursion: this recursive approach doesn't work for defining functions.

;Parameter Lists: The use of (f . rest1) and (x ...) (b . rest2) as parameters is not a standard way to define a procedure, and it's likely to cause syntax errors.
;Cons cells are not typically used to define input arguments in Scheme procedures. Input arguments in Scheme (and most programming languages) are usually specified 
;using standard parameter lists.








              
