{-
We want to define a data structure, called Listree, to define structures working both as lists and as binary
trees, like in the next figure.

1) Define a datatype for Listree.

2) Write the example of the figure with the defined data structure.

3) Make Listree an instance of Functor.

4) Make Listree an instance of Foldable.

5) Make Listree an instance of Applicative.
-}

--1)
--data Listree a = List [Listree a]  | Tree (Listree a) (Listree a) --non va bene perchè se [] a quel punto poi hai solo una lista o liste di liste
data Listree a = Nil | Cons a (Listree a) | Branch (Listree a) (Listree a)

--2)
exfig = Branch (Cons 1 Nil) (Cons 2 (Branch  (Branch (Cons 3 Nil) (Cons 4 Nil))  (Cons 5 (Cons 6 (Cons 7 Nil)))  ))

--3)
instance Functor Listree where
    fmap f Nil = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)
    fmap f (Branch xs ys) = Branch (fmap f xs) (fmap f ys)

--4)
instance Foldable Listree where
    foldr f z Nil = z
    foldr f z (Cons x xs) = f x $ (foldr f z xs)
    foldr f z (Branch xs ys) = foldr f (foldr f z ys) xs


--5)
Nil +++ branch = branch
Nil +++ cons = cons
(Cons x xs) +++ branch = (Cons x xs+++branch)
(Branch l r) +++ cons = (Branch l r+++cons)

concatTL t = foldr (+++) Nil t

concMapTL f t = concatTL $ (fmap f t)

instance Applicative Listree where
    pure x = Cons x Nil
    fs<*>tl = concMapTL $ (\f -> fmap f tl) fs




