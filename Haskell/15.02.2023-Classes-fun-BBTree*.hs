{-
We want to define a data structure for binary trees, called BBtree, where in each node are stored two values of the
same type. Write the following:

1. The BBtree data definition.

2. A function bb2list which takes a BBtree and returns a list with the contents of the tree.

3. Make BBtree an instance of Functor and Foldable.

4. Make BBtree an instance of Applicative, using a “zip-like” approach, i.e. every function in the first
argument of <*> will be applied only once to the corresponding element in the second argument of <*>.

5. Define a function bbmax, together with its signature, which returns the maximum element stored in the
BBtree, if present, or Nothing if the data structure is empty.
-}

--1)
data BBtree a = BBtree a a (BBtree a) (BBtree a) | Nil

--2)
bb2list :: BBtree a -> [a]
bb2list Nil = []
bb2list (BBtree x y xs ys) = [x,y] ++ (fmap bb2list xs) ++ (fmap bb2list ys)

--3)
instance Functor BBtree where
    fmap f Nil = Nil
    fmap f (BBtree x y xs ys) = (BBtree (f x) (f y) (fmap f xs) (fmap f ys))
    
instance Foldable BBtree where   
    foldr f z Nil = z
    foldr f z (BBtree x y xs ys) = f x $ (f y (foldr f (foldr f z ys) xs) ) --parentesi oppure $
    
--4)  
instance Applicative BBtree where
    pure v = (BBtree v v Nil Nil)
    --zip-like
    BBnil <*> y = BBnil
    x <*> BBnil = BBnil
    (BBtree x y t1 t2) <*> (BBtree x' y' t1' t2') = (BBtree (x x') (y y') (t1 <*> t1') (t2 <*> t2'))

    
--5)
bbmax :: (Ord a) => BBtree a -> Maybe a
bbmax BBnil = Nothing
bbmax t@(BBtree t1 x y t2) = Just ( foldr max x t )
