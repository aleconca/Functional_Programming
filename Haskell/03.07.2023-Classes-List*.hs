{-
1. Define a data structure, called D2L, to store lists of possibly depth two, e.g. like [1,2,[3,4],5,[6]].

2. Implement a flatten function which takes a D2L and returns a flat list containing all the stored values in it
in the same order.

3. Make D2L an instance of Functor, Foldable, Applicative.
-}

{- Grammar:
    S->Y
    Y->[a]Y
    Y-> aY
    Y->Nil
    
    le parentesi esterne le metto io
    
    D2Cons2 [2, D2Cons2 [3, 4], 5, D2Cons2 [6]]
-}


data D2L a = D2Nil | D2Cons1 a (D2L a) | D2Cons2 [a] --non puoi annestare con costruttori, ma solo con D2L a

flatten :: D2L a -> [a]
flatten D2Nil = []
flatten (D2cons1 x xs) = x : flatten xs
flatten (D2Cons2 xs ys) = xs ++ flatten ys --xs = lista di elementi 'semplici'; ys=lista di D2L a


instance Functor D2L where
    fmap f D2Nil = D2Nil
    fmap f (D2Cons1 x xs) = D2Cons1 (f x) (fmap f xs)
    fmap f (D2Cons2 xs ys) = D2Cons2 (fmap f xs) (fmap f ys)
    
    

instance Foldable D2L where
    foldr f z D2Nil = D2Nil
    foldr f z (D2Cons1 x xs) = f x (foldr f z xs)
    --foldr f z (D2Cons2 xs ys) = (foldr f z ( xs ++ flatten ys) )
    foldr f i (D2Cons2 xs ys) = (foldr f (foldr f i ys) xs)


D2Nil +++ t = t
t +++ D2Nil = t
(D2Cons1 x xs) +++ t = D2Cons1 x (xs +++ t)
(D2Cons2 xs ys) +++ t = D2Cons2 xs (ys +++ t)


instance Applicative D2L where
    pure v = D2Cons1 x D2Nil
    functorf<*>functorx = foldr (+++) D2Nil (fmap (\f -> fmap f functorx) functorf) --flatten? 
    






