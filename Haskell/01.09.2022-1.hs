{-
We want to implement a binary tree where in each node is stored data, together with the number of nodes
contained in the subtree of which the current node is root.

1. Define the data structure.

2. Make it an instance of Functor, Foldable, and Applicative.
-}


data Ctree a = Cnil | Ctree a Int (Ctree a) (Ctree a) deriving (Show, Eq)

instance Functor Ctree where
    fmap f Cnil = Cnil
    fmap f (Ctree x n sx dx) = Ctree (f x) n (fmap f sx) (fmap f dx)



--ctree2list :: Ctree a -> [a]
--ctree2listctree2list Cnil = []
--ctree2list Ctree x n sx dx = x : concatMap ctree2list sx ...?

--instance Foldable Ctree where
--    foldr f z Cnil = z
--    foldr f z t = foldr f z $ ctree2list t

instance Foldable Ctree where
    foldr f z Cnil = z
    foldr f z (Ctree x _ t1 t2) = f x $ foldr f (foldr f z t2) t1 --why apply?


cvalue Cnil = 0
cvalue (Ctree _ x _ _) = x

cnode x t1 t2 = Ctree x ((cvalue t1) + (cvalue t2) + 1) t1 t2 --ricaloco #sottonodi
cleaf x = cnode x Cnil Cnil
    
x +++ Cnil = x
Cnil +++ x = x
(Ctree x v t1 t2) +++ t = cnode x t1 (t2 +++ t)

ttconcat = foldr (+++) Cnil
ttconcmap f t = ttconcat $ fmap f t

instance Applicative Ctree where
    pure = cleaf
    x <*> y = ttconcmap (\f -> fmap f y) x
    
