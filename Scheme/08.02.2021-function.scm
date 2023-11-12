;Write a function 'depth-encode' that takes in input a list possibly containing
;other lists at multiple nesting levels, and returns it as a flat list where
;each element is paired with its nesting level in the original list.

;E.g. (depth-encode '(1 (2 3) 4 (((5) 6 (7)) 8) 9 (((10))))) 
;returns
;((0 . 1) (1 . 2) (1 . 3) (0 . 4) (3 . 5) (2 . 6) (3 . 7) (1 . 8) (0 . 9) (3 . 10))
