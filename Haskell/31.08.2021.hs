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
it over the second one.

example:
class (Functor f) => Applicative f where  
    pure :: a -> f a  
    (<*>) :: f (a -> b) -> f a -> f b
    
t starts the definition of the Applicative class and it also introduces a class constraint. It says that if we want to make a type constructor 
part of the Applicative typeclass, it has to be in Functor first. That's why if we know that if a type constructor is part of the Applicative typeclass, 
it's also in Functor, so we can use fmap on it. 

instance Applicative Maybe where  
    pure x = Just x
    Nothing <*> _ = Nothing  
    (Just f) <*> something = fmap f something
-}
instance Applicative Slist where
    pure v = Slist l pure v
    (Slist x fs)<*>(Slist y xs) = Slist (x*y) (fs<*>xs) --iterate, come apply in scheme

    
{- 
class (Applicative m) = > Monad m where but we write

class Monad m where  
    return :: a -> m a --does the same thing as the pure function from the Applicative type class 
  
    (>>=) :: m a -> (a -> m b) -> m b  -- bind. It's like function application, only instead of taking a normal value and feeding it to a normal function, 
                                          it takes a monadic value (that is, a value with a context) and feeds it to a function that takes a normal value but 
                                          returns a monadic value.
  
    (>>) :: m a -> m b -> m b -- default implementation
    x >> y = x >>= \_ -> y  
  
    fail :: String -> m a  -- fail. We never use it explicitly in our code.
    fail msg = error msg 
    
example:
instance Monad Maybe where  
    return x = Just x  
    Nothing >>= f = Nothing  
    Just x >>= f  = f x  
    fail _ = Nothing 
    
-}
makeSlist v = Slist (length v) v

instance Monad Slist where
    fail Slist _ = Slist 0 []
    (Slist n xs) >>= f = makeSlist (xs >>= (\x -> let Slist n xs = f x in xs) ) 
    --it takes a monadic value (that is, a value with a context) and feeds it to a function that takes a normal value but returns a monadic value.
    --makeSlist is used to create a new Slist from the concatenated list and its length.

