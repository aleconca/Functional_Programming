{-

Define a data type that stores an m by n matrix as a list of lists by row.
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
new :: Int -> Int -> a -> Matrix a 
new i j fill = [ [ fill | _ <- [1..j] ] | _ <- [1..i] ]


--2)
replace :: Matrix a -> Int -> Int -> a -> Matrix a 
replace (Matrix xs) i j new = let m = length xs
                                  n = length (xs!!i) in [[ if (c==j) && (r==i) then new else (lookup c r (Matrix xs) ) | c <- [1..n] ] | r <- [1..m]]


--3)
lookup :: Int -> Int -> Matrix a -> a 
lookup i j (Matrix xs) = (xs!!i)!!j

--4)
instance Functor Matrix where
    fmap f (Matrix xs) = Matrix (map (\x -> (map f x)) xs)


instance Foldable Matrix where 
    foldr f i (Matrix xs) = foldr (\x acc -> (foldr f acc x)) i xs

--5)

concatCol (Matrix xs) (Matrix ys) = Matrix (xs ++ ys)

concatRow (Matrix (x:xs)) (Matrix (y:ys)) = Matrix ((x++y) : (concatRow (Matrix xs) (Matrix ys)))
concatRow (Matrix []) m = m 
concatRow m (Matrix []) = m


concatM (Matrix x) = (foldr (\x' acc -> concatCol (foldr concatRow (Matrix []) x') acc) (Matrix []) x)

concatmapM :: (a -> Matrix b) -> Matrix a -> Matrix b 
concatmapM f xs = concatM $ (fmap f xs)

instance Applicative Matrix where 
    pure x = new 1 1 x 
    fs<*>m = concatmapM (\f -> fmap f m) fs

    





