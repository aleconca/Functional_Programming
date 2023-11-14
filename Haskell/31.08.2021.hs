{-
Consider a Slist data structure for lists that store their length. Define the Slist data structure, and make it
an instance of Foldable, Functor, Applicative and Monad.
-}

data Slist a = Slist Int [a] --deriving (Show, Eq)

instance Foldable Slist where
    foldr f i (Slist n xs) = foldr f i xs

instance Functor Slist where
    fmap f (Slist n xs) = Slist n fmap xs

instance Applicative Slist where
    pure v = Slist l pure v
    (Slist x fs)<*>(Slist y xs) = Slist (x*y) (fs<*>xs)

makeSlist v = Slist (length v) v

instance Monad Slist where
    fail Slist _ = Slist 0 []
    (Slist n xs) >>= f = makeSlist (xs >>= (\x -> let Slist n xs = f x
                                                  in xs))

