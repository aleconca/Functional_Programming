{-
Consider a Tvtl (two-values/two-lists) data structure, which can store either two values of a given type, or
two lists of the same type.
Define the Tvtl data structure, and make it an instance of Functor, Foldable, and Applicative
-}


data Tvtl a = Tv a a | Tl [a] [a] --ok

instance Functor Tvtl where--ok
    fmap f (Tv x y)  = Tv (f x) (f y)
    fmap f (Tl xs ys) = Tl (fmap f xs) (fmap f ys)
    
    
instance Foldable Tvtl where --ok
    foldr f z (Tv x y) = f x (f y z)
    foldr f z (Tl xs ys) = foldr f (foldr f z ys) xs
    
--This is a function   
(Tv x y) +++ (Tv z w) = Tl [x,y] [y,w]
(Tv x y) +++ (Tl l r) = Tl (x:l) (y:r)
(Tl l r) +++ (Tv x y) = Tl (l++[x]) (r++[y])
(Tl l r) +++ (Tl x y) = Tl (l++x) (r++y)

--That will be used in here
tvtlconcat t = foldr (+++) (Tl [][]) t
tvtlcmap f t = tvtlconcat $ fmap f t --perchè $ ?


instance Applicative Tvtl where
    pure x = Tl [x] []
    x <*> y = tvtlcmap (\f -> fmap f y) x 
    --perchè non distinguo tra Tv e Tl?
    --perchè necessito di tvtlcmap? 
