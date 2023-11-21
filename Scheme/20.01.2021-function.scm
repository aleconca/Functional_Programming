;Define a pure function (i.e. without using procedures with side effects, such as set!) which takes a multi-level list, 
;i.e. a list that may contain any level of lists, and converts it into a data structure where each list is converted into a vector. 

;E.g.
;The result of (multi-list->vector '(1 2 (3 4) (5 (6)) "hi" ((3) 4))))
;should be: '#(1 2 #(3 4) #(5 #(6)) "hi" #(#(3) 4))

;The vector function in Scheme takes multiple arguments and returns a newly created vector containing those arguments.

(define (multi-list->vector lst)
  (cond
    ((not (list? lst)) lst)  ; If lst is not a list, return lst as is
    ((null? (filter list? lst)) (apply vector lst))  ; If lst contains no sublists, create a vector from lst
    (else (apply vector (map multi-list->vector lst)))))  ; Recursively apply multi-list->vector to each element of lst and create a vector
