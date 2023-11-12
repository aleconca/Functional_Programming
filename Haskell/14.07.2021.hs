{-
1) Define a "generalized" zip function which takes a finite list of possibly infinite lists, and returns a
possibly infinite list containing a list of all the first elements, followed by a list of all the second elements,
and so on.
E.g. gzip [[1,2,3],[4,5,6],[7,8,9,10]] ==> [[1,4,7],[2,5,8],[3,6,9]]
2) Given an input like in 1), define a function which returns the possibly infinite list of the sum of the two
greatest elements in the same positions of the lists.
E.g. sum_two_greatest [[1,8,3],[4,5,6],[7,8,9],[10,2,3]] ==> [17,16,15]
-}
