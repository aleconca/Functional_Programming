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
