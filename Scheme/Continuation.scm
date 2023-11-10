#lang racket

;a contin­u­a­tion is a func­tion
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

