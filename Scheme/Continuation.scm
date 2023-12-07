#lang racket

;Keyword: A continuation is the variable we pass to the lambda. When we call it, we save the context, i.e. anything that comes before and after.
;when we unvoke the continuation, we switch from the code to the saved context.


;--------------------------
;when to use continuations:

;Non-Local Exits: If you need to exit a deeply nested computation and jump to a specific point in the program, call/cc allows you to capture the continuation 
;at the point of the call and invoke it later.

(define (foo)
  (call/cc
   (lambda (exit)
     (if (= 42 (prompt "Enter a number: "))
         (exit 'success)
         'failure))))

;Implementing Exceptions: You can use call/cc to implement exception handling mechanisms where an exceptional condition can be signaled and handled at a higher 
;level in the call stack.

(define (divide x y)
  (call/cc
   (lambda (exit)
     (if (= y 0)
         (exit 'division-by-zero)
         (/ x y)))))

;Custom Control Flow: call/cc enables the creation of custom control flow structures. For example, you can implement coroutines, generators, or other advanced control 
;flow patterns.

(define (generator)
  (let ((state 0))
    (lambda ()
      (call/cc
       (lambda (exit)
         (set! state (+ state 1))
         (exit state))))))

(define gen (generator))
(gen) ; Returns 1
(gen) ; Returns 2


;--------------------------------------------------------------------------------------------------------------------

;a contin­u­a­tion 
(define c #f)
(+ 1 (+ 2 (+ 3 (+ (let/cc here (set! c here) 4) 5)))) ; 15
(+ 1 (+ 2 (+ 3 (+ 20 5)))) ; 31 (same as `(c 20)`)
(c 20) ; 31


;though Racket has no return state­ment, it can be imple­mented with a contin­u­a­tion:
(define (find-multiple factor)
  (let/cc return
    (for ([num (shuffle (range 2000))])
         (when (zero? (modulo num factor))
           (return num)))))

(find-multiple 43);result ok

(define (find-multiple1 factor)
    (for ([num (shuffle (range 2000))])
         (when (zero? (modulo num factor))
           num)))

(display (find-multiple1 43));#void


;se vuoi ritornare 42 devi fare :
(define (ritorna-un-numero)
  42)
(define risultato (ritorna-un-numero))
risultato ; Stampa 42

;In Scheme, le funzioni restituiscono un valore attraverso la valutazione dell'ultima espressione nel loro corpo.


;Other continuations-----------------------------------------------------------------------------------------------
#lang racket

; call/cc : ((α → β) → α) → α

; call/cc : ?

(+ 2 3)


(+ 2 (call/cc (λ (continuation) 3)))

; call/cc : (? → ?) → Number

(+ 2 (call/cc (λ (continuation) (continuation 3))))
; (define (continuation x) (+ 2 x))

; call/cc : ((Number → ?) → ?) → Number

(+ 2 (call/cc (λ (continuation) (continuation 3) 6)))

; call/cc : ((Number → ?) → Number) → Number

(+ 2 (call/cc (λ (continuation) (zero? (continuation 3)) 6)))
(+ 2 (call/cc (λ (continuation) (string-length (continuation 3)) 6)))

; call/cc : ((Number → β) → Number) → Number

(string-append "Hello " (call/cc (λ (continuation) (zero? (continuation "World")) "NOT ME")))

; call/cc : ((α → β) → α) → α

(write (if #t 23 "Hello"))


(string-append "Hello " (call/cc (λ (continuation) (zero? (continuation "World")) #f)))

; call/cc : ((α → β) → γ) → (α ∪ γ)

