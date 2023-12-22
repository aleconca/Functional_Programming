{-Define a data type that stores an m by n matrix as a list of lists by row.
After defining an appropriate data constructor, do the following:
1. Define a function `new' that takes as input two integers m and n
   and a value `fill', and returns an m by n matrix whose elements are all equal to `fill'.
2. Define function `replace' such that, given a matrix m, the indices i, j of one of its elements,
   and a new element, it returns a new matrix equal to m except for the element
   in position i, j, which is replaced with the new one.
3. Define function `lookup', which returns the element in a given position
   of a matrix.
4. Make the data type an instance of Functor and Foldable.
5. Make the data type an instance of Applicative.

In your implementation you can use the following functions:
splitAt :: Int -> [a] -> ([a], [a])
unzip :: [(a, b)] -> ([a], [b])
(!!) :: [a] -> Int -> a
-}
