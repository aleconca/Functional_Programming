{-
We want to implement a queue, i.e. a FIFO container with the two operations
enqueue and dequeue with the obvious meaning. A functional way of doing this is
based on the idea of using two lists, say L1 and L2, where the first one is used
for dequeuing (popping) and the second one is for enqueing (pushing) When
dequeing, if the first list is empty, we take the second one and put it in the
first, reversing it.

1) Define Queue and make it an instance of Eq
2) Define enqueue and dequeue, stating their types
3) Make Queue an instance of Functor and Foldable
4) Make Queue an instance of Applicative
-}

--1)
data Queue a = Queue [a] [a] 

instance Eq Queue where
    (Queue xs ys) == (Queue xs' ys') = (xs==xs') && (ys == ys')

--2)
enqueue :: a -> Queue a -> Queue a
enqueue x (Queue [] []) = Queue [x] []
enqueue x (Queue [] ys) = Queue [x] ys
enqueue x (Queue xs ys) = Queue [x]++xs ys

dequeue :: Queue a -> Queue a
dequeue (Queue [] (y:ys) = Queue [] ys
dequeue (Queue xs []) = Queue [] reverse(xs)
dequeue (Queue xs (y:ys)) = Queue xs ys

{-
dequeue :: Queue a -> (Maybe a, Queue a)
dequeue q@(Queue [] []) = (Nothing, q)
dequeue (Queue (x:xs) v) = (Just x, Queue xs v)
dequeue (Queue [] v) = dequeue (Queue (reverse v) [])
-}


--3)
instance Functor Queue where
    fmap f (Queue xs ys) = Queue (fmap f xs) (fmap f ys)

instance Foldable Queue where
    foldr f z (Queue xs ys) = foldr f (foldr f z xs) ys

--4)
instance Applicative Queue where
    pure x = Queue [x] []
    (Queue fs gs)<*>(Queue xs ys) = Queue (fs<*>xs)  (gs<*>ys) --lists are instance of Functor and Applicative
    --concatMap (\f -> fmap xs) fs   
    --concatMap (\g -> fmap ys) gs
    
to_list (Queue x y) = x ++ reverse y

q1 +++ (Queue x y) = Queue ((to_list q1) ++ x) y

qconcat q = foldr (+++) (Queue [][]) q

instance Applicative Queue where
    pure x = Queue [x] []
    fs <*> xs = qconcat $ fmap (\f -> fmap f xs) fs    
    



