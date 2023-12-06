{-
A deque, short for double-ended queue, is a list-like data structure that supports efficient element
insertion and removal from both its head and its tail. Recall that Haskell lists, however, only support O(1)
insertion and removal from their head.

Implement a deque data type in Haskell by using two lists: the first one containing elements from the
initial part of the list, and the second one containing elements form the final part of the list, reversed.
In this way, elements can be inserted/removed from the first list when pushing to/popping the deque's
head, and from the second list when pushing to/popping the deque's tail.

1) Write a data type declaration for Deque.

2) Implement the following functions:

• toList: takes a Deque and converts it to a list
• fromList: takes a list and converts it to a Deque
• pushFront: pushes a new element to a Deque's head
• popFront: pops the first element of a Deque, returning a tuple with the popped element and the new Deque
• pushBack: pushes a new element to the end of a Deque
• popBack: pops the last element of a Deque, returning a tuple with the popped element and the new Deque

3) Make Deque an instance of Eq and Show.

4) Make Deque an instance of Functor, Foldable, Applicative and Monad.

You may rely on instances of the above classes for plain lists.
-}

--1)
data Deque a =  Deque [a] [a]

--2)
toList :: Deque a -> [a]
toList (Deque xs ys) = xs++(reverse ys)

fromList :: [a] -> Deque a
fromList l = let half = length l `div` 2
             in Deque (take half l) (reverse $ drop half l) -- (take half (reverse l) )

pushFront :: Deque a -> a -> Deque a 
pushFront (Deque xs ys) x = Deque [x]++xs ys

popFront :: Deque a -> (a,Deque a)
popFront (Deque (x:xs) ys) = (x, Deque xs ys)
popFront (Deque [] []) = error "Pop on empty Deque!"
popFront (Deque [] [y]) = (y, Deque [] [])
popFront (Deque [] back) = popFront $ fromList back

pushBack :: a -> Deque a -> Deque a 
pushBack x (Deque xs ys) = Deque xs ys++x


popBack :: Deque a -> (a,Deque a)
popBack (Deque xs (y:ys)) = (y,Deque xs ys)
popBack (Deque [] []) = error "Pop on empty Deque!"
popBack (Deque [x] []) = (x, Deque [] [])
popBack (Deque front []) = popBack $ fromList front

--3)
instance (Eq a) => Eq (Deque a) where
    --(Deque xs ys) == (Deque xs' ys') = (xs == xs') && (ys == ys')
    d1 == d2 = toList d1 == toList d2
    

instance (Show a) => Show (Deque a) where
    --show Deque xs ys = show xs ++ show (reverse ys) però ottengo 2 liste separate
    show d = show (toList d)

--4)
instance Functor Deque where
    fmap f (Deque xs ys) = Deque (map f xs) (map f ys)

instance Foldable Deque where
    foldr f z d = fromList ( foldr f z (toList d) )


instance Applicative Deque where
    pure v = Deque [v] []
    --(Deque fs gs)<*>(Deque xs ys) = Deque (concatMap (\f -> map f xs) fs) (concatMap (\f -> map f ys) gs)
    df <*> dx = fromList ( toList df <*> toList dx ) --lists are an instance of Applicative: posso usare direttamente <*>

instance Monad Deque where 
    --(>>=) :: m a -> (a -> m b) -> m b
    --d >>= f = fromList $ toList d >>= f
    --concatMap :: (a -> [b]) -> [a] -> [b]
    d >>= f = fromList $ concatMap (toList . f) ( toList d ) --voglio far si che f ritorni una lista, altrimenti non posso fare 
                                                             -- la concatMap; motivo per cui fare toList d >>= f non va bene 
    
    
    
    
    
    
    
    
