{-
Consider a Slist data structure for lists that store their length. Define the Slist data structure, and make it
an instance of Foldable, Functor, Applicative and Monad.
-}

data Slist a = Slist Int [a] --deriving (Show, Eq)

instance Foldable Slist where
    foldr f i (Slist n xs) = foldr f i xs

instance Functor Slist where
    fmap f (Slist n xs) = Slist n fmap xs

{-
1. pure should take a value and put it in some sort of default (or pure) minimal context that still yields that value.

2. <*> takes a functor that has a function in it and another functor and sort of extracts that function from the first functor and then maps 
it over the second one. When I say extract, I actually sort of mean run and then extract, maybe even sequence. 
-}
instance Applicative Slist where
    pure v = Slist l pure v
    (Slist x fs)<*>(Slist y xs) = Slist (x*y) (fs<*>xs)

makeSlist v = Slist (length v) v

instance Monad Slist where
    fail Slist _ = Slist 0 []
    (Slist n xs) >>= f = makeSlist (xs >>= (\x -> let Slist n xs = f x
                                                  in xs))

