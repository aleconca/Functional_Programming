{-1) Define a Tritree data structure, i.e. a tree where each node has at most 3 children, and every node contains
a value.
2) Make Tritree an instance of Foldable and Functor.
3) Define a Tritree concatenation t1 +++ t2, where t2 is appended at the bottom-rightmost position of t1.
4) Make Tritree an instance of Applicative.-}


--1)
data Tritree a = Node a (Tritree a) (Tritree a) (Tritree a) | Nil

--2)
instance Functor Tritree where
    fmap f Nil = Nil
    fmap f (Node v one two three) = Node (f v) (fmap f one) (fmap f two) (fmap f three)

instance Foldable Tritree where
    foldr f z Nil = z
    foldr f z (Node v one two three) = f v $ foldr f (foldr f (foldr f z three) two) one

--3)
x +++ Nil = x
Nil +++ x = x
(Node x t1 t2 Nil) +++ t = (Node x t1 t2 t)
(Node x t1 t2 t3) +++ t = (Node x t1 t2 (t3 +++ t))

--4)

{-
ttconcat t = foldr (+++) Nil t
ttconcmap f t = ttconcat $ fmap f t

instance Applicative Tritree where
    pure x = (Tritree x Nil Nil Nil)
    x <*> y = ttconcmap (\f -> fmap f y) x
-}

instance Applicative Tritree where
    pure x = (Node x Nil Nil Nil)
    fs<*>tt = foldr (+++) Nil (fmap (\f -> fmap f tt) fs)
    
    
