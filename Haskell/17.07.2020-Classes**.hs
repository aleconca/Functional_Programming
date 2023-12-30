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

data Matrix a = Matrix [[a]]

--1)
new :: a -> a -> a -> Matrix a
new x y fill = Matrix [row(x,y,fill)] where
                row(x,y,fill) | y>0 = fill : row(fill,x,y-1),
                row(x,0,fill) | x>0 = row(x-1,y,fill).

new :: a -> a-> a -> Matrix a
new m n fill = Matrix [[fill | _ <- [1..n]] | _ <- [1..m]]

--2)
replace :: Int -> Int -> a -> Matrix a -> Matrix a
replace i j x (Matrix rows) = let (rowsHead, r:rowsTail) = splitAt i rows --trovi la riga
                                  (rHead, x':rTail) = splitAt j r --trovi la colonna
                              in Matrix $ rowsHead ++ ((rHead ++ (x:rTail)):rowsTail)
                              
--3)
lookup :: Int -> Int -> Matrix a -> a
lookup i j (Matrix rows) = (rows !! i) !! j


--4)
--instance Functor Matrix where
    --fmap f (Matrix rows) = Matrix [ [f(v) | v <- row] | row <- rows]


instance Functor Matrix where
  fmap f (Matrix rows) = Matrix $ map (\r -> map f r) rows

instance Foldable Matrix where
  foldr f e (Matrix rows) = foldr (\r acc -> foldr f acc r) e rows



hConcat :: Matrix a -> Matrix a -> Matrix a
hConcat (Matrix []) m2 = m2
hConcat m1 (Matrix []) = m1
hConcat (Matrix (r1:r1s)) (Matrix (r2:r2s)) =
  let (Matrix tail) = hConcat (Matrix r1s) (Matrix r2s)
  in Matrix $ (r1 ++ r2) : tail

vConcat :: Matrix a -> Matrix a -> Matrix a
vConcat (Matrix rows1) (Matrix rows2) = Matrix $ rows1 ++ rows2

concatMapM :: (a -> Matrix b) -> Matrix a -> Matrix b
concatMapM f (Matrix rows) =
  let empty = Matrix []
  in foldl
     (\acc r -> vConcat acc $ foldl (\acc x -> hConcat acc (f x)) empty r)
     empty
     rows

instance Applicative Matrix where
  pure x = Matrix [[x]]
  fs <*> xs = concatMapM (\f -> fmap f xs) fs










