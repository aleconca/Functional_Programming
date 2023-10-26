#lang racket

;Define a pure function multi-merge with a variable number of arguments (all of them must be ordered lists of
;numbers), that returns an ordered list of all the elements passed. It is forbidden to use external sort functions.
;E.g. when called like:
;(multi-merge '(1 2 3 4 8) '(-1 5 6 7) '(0 3 8) '(9 10 12))
;it returns: '(-1 0 1 2 3 3 4 5 6 7 8 8 9 10 12)


;define an helper function to order the lists while merging them
;1. a1 => (1 2 3 4 8)
   ;a2 => ()
   ;return a1->accumulatore a2=(1 2 3 4 8)
   
;2. a1 => (-1 5 6 7)
   ;a2 => (1 2 3 4 8)
   
(define (merge a1 a2)
   (cond ((null? a1) a2)
         ((null? a2) a1)
         (else (let ((x (car a1))
                     (y (car a2)))
               (if (< x y)
                   (cons x (merge (cdr a1) a2))
                   (cons y (merge a1 (cdr a2))))))))


(define (multi-merge . data)
  ;apply merge to data and store result of foldl in a new list
  ;foldl:
  ;La funzione binaria (merge in questo caso) verrà applicata in modo iterativo agli elementi della lista. 
  ;Questa funzione deve prendere due argomenti: l'accumulatore (a2='()) e l'elemento corrente della lista (a1), eseguire qualche operazione su di essi e restituire il risultato. 
  ;Ad esempio, se vuoi sommare gli elementi di una lista, la tua funzione binaria sarà una funzione che somma due numeri.

L'accumulatore iniziale, che è il valore iniziale dell'accumulatore prima di iniziare ad attraversare la lista. Questo è spesso l'elemento neutro per l'operazione che si desidera eseguire. Ad esempio, per la somma, l'accumulatore iniziale sarà 0.

La lista di elementi su cui desideri eseguire l'operazione.
  (foldl merge '() data))


(multi-merge '(1 2 3 4 8) '(-1 5 6 7) '(0 3 8) '(9 10 12))
