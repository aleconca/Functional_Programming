{-
Define a data-type called BTT which implements trees that can be binary or ternary, and where every
node contains a value, but the empty tree (Nil). Note: there must not be unary nodes, like leaves.

1) Make BTT an instance of Functor and Foldable.

2) Define a concatenation for BTT, with the following constraints:

• If one of the operands is a binary node, such node must become ternary, and the other operand
will become the added subtree (e.g. if the binary node is the left operand, the rightmost node of
the new ternary node will be the right operand).

• If both the operands are ternary nodes, the right operand must be appened on the right of the left
operand, by recursively calling concatenation.

3) Make BTT an instance of Applicative.
-}



--1)
data BTT a = BT a (BTT a) (BTT a) | TT a (BTT a) (BTT a) (BTT a) | Nil 


--2) 
--fmap :: (a -> b) -> f a -> f b 
instance Functor BTT where
    fmap f Nil = Nil
    fmap f (BT v xs ys) = (BT (f v) (fmap f xs) (fmap f ys))
    fmap f (TT v xs ys zs) = (TT (f v) (fmap f xs) (fmap f ys) (fmap f zs))
    
--foldr :: (a -> b -> b) -> b -> t a -> b  
instance Foldable BTT where
    foldr f z Nil = Nil
    foldr f z (BT v xs ys) = f v $ (foldr f (foldr f z ys) xs)
    foldr f z (TT v xs ys zs) =  f v $ (foldr f (foldr f (foldr f z zs) ys) xs)

--3)
x (+++) Nil = x
Nil (+++) x = x
(BT v xs ys)(+++)t = (TT v t xs ys)
t(+++)(BT v xs ys) = (TT v xs ys t)
(TT v xs ys zs)(+++)t@(TT v' xs' ys' zs') = (TT v xs ys (zs (+++) t) ) 

ltconcat t = foldr (+++) Nil t
ltconcmap f t = ltconcat $ fmap f t

--4)
instance Applicative BTT where
    pure v = (BT v Nil Nil)
    x<*>xs = ltconcmap (\f -> (fmap f x)) xs
