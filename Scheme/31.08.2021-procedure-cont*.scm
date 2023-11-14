#lang racket


;1) Define a procedure which takes a natural number n and a default value, and creates a n by n matrix
;filled with the default value, implemented through vectors (i.e. a vector of vectors).


;input: n, def 
;output: nxn matrix filled with def
;hint: use vectors
(define (def-sq-matrix n def)
  
  (let loop ((i 0) (vect (make-vector n)))
    (when (< i n)
       (vector-set! vect i (make-vector n def))
       ( loop (+ i 1) vect ))
    vect
    )
  
   )

   

;(make-vector size [v]) 
;Returns a mutable vector with size slots, where all slots are initialized to contain v.
;Note that v is shared for all elements, so for mutable data, mutating an element will affect other elements.  

(def-sq-matrix 4 1)


;2) Let S = {0, 1, ..., n-1} x {0, 1, ..., n-1} for a natural number n. Consider a n by n matrix M, stored in a
;vector of vectors, containing pairs (x,y) ∈ S, as a function from S to S (e.g. f(2,3) = (1,0) is represented
;by M[2][3] = (1,0)). Define a procedure to check if M defines a bijection (i.e. a function that is both injective and surjective) 


;Keyword: A continuation is the variable we pass to the lambda. When we call it, we save the context, i.e. anything that comes before and after.
;when we unvoke the continuation, we switch from the code to the saved context.

(define (bijection? m)
;CONTEXT----------------------------
 (define size (vector-length m))
 (define seen? (create-matrix size #f));vettore di vettori (0:(#f #f #f) 1:(#f #f #f) 2:(#f #f #f))
;until here-------------------------
  
 (call/cc (lambda (exit);create the continuation-->exit variable
            
            (let loop ((i 0))
              (when (< i size)
                (let loop1 ((j 0))
                  (when (< j size)

                    ;datum=(1,2)
                    (let ((datum (vector-ref (vector-ref m i) j)))
                      ;se  datum=(0,2) : (vector-ref 0:(#f '#f' #f) 2) == '#f'
                      (if (vector-ref (vector-ref seen? (car datum)) (cdr datum))
                          
                          (exit #f);what do we do here? we call the continuation, so we exchange all the loops code with the saved context.
                                   ;our code becomes: (define (bijection? m) 
                                                        ;(define size (vector-length m))
                                                        ;(define seen? (create-matrix size #f)) 
                                                        ;(call/cc (lambda (exit) (#f)))
                                                      ;)
                                   ;so in the end we get a false.

                          
                          (vector-set! (vector-ref seen? (car datum)) (cdr datum) #t)));seen
            
                    (loop1 (+ 1 j))))
                (loop (+ 1 i))))
            
            #t);lambda must return something-->we return true if everything went well
          )
  ;NO OTHER CONTEXT--------------------------------------------------------------------------------
  )







    







