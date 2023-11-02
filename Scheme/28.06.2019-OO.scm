;Consider this data definition in Haskell: data Tree a = Leaf a | Branch (Tree a) a (Tree a)
;Define an OO analogous of this data structure in Scheme using the technique of "closure as classes" as seen
;in class, defining the map and print methods, so that:
;(define t1 (Branch (Branch (Leaf 1) -1 (Leaf 2)) -2 (Leaf 3)))
;((t1 'map (lambda (x) (+ x 1))) 'print)
;should display: (Branch (Branch (Leaf 2) 0 (Leaf 3)) -1 (Leaf 4))
