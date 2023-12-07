#lang racket

;Consider the following program, containing two errors:

(define (ap state equality)
  (let ((local state))
    (lambda (f)
      (let ((new (f local))
            (flag (equality new local)))
        (when flag
          (set! local new))
        (cons flag new)))))

(define (g f v equality)
  (let ((alpha (ap v equality)))
    (let beta ((v (alpha f)))
      (call/cc
       (lambda (done)
         (when (car v)
           (done (cdr v)))
         (beta (alpha f)))))))

;1) Describe how it works;
;2) how can we rewrite g to avoid using call/cc;
;3) why it is broken and how to fix it.
