{-
Define a data structure for Binary Search Trees (BST), i.e. ordered trees where
elements less than the value stored in the current node are in the left subtree,
while elements greater than or equal to it are in the right subtree. Define a
put operation to put a value in a BST, and a member operation to check if a
value is present or not. Provide all the types of the defined operations.

Make BST an instance of Functor and Foldable.
-}


data Bst a = Nil | Node a (Bst a) (Bst a) 

put :: Ord => v -> Bst a -> Bst a
put x Nil = Node x Nil Nil
put x Node x' l r | x < x' = Node x' (put x l) r 
put x Node x' l r  = Node x' l (put x r) 

member :: Ord => v -> Bst a -> Bool
member x Nil = False
member x Node x' l r | x == x' = True
member x Node x' l r | x < x' = (member x l) 
member x Node x' l r = (member x r)

instance Functor Bst where
    fmap f Nil = Nil
    fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)

instance Foldable Bst where
    foldr f z Nil = Nil
    foldr f z (Node x l r) = (foldr f z (f x (foldr f z r)) l)
