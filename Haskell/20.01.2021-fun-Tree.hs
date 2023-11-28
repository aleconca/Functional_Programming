{-
Consider the following data structure for general binary trees:

  data Tree a = Empty | Branch (Tree a) a (Tree a) deriving (Show, Eq)

Using the State monad as seen in class:

1) Define a monadic map for Tree, called mapTreeM.

2) Use mapTreeM to define a function which takes a tree and returns a tree containing list of elements that are all the data found in the original tree in a depth-first visit.

E.g.
From the tree: (Branch (Branch Empty 1 Empty) 2 (Branch (Branch Empty 3 Empty) 4 Empty))
we obtain:
Branch (Branch Empty [1] Empty) [1,2] (Branch (Branch Empty [1,2,3] Empty) [1,2,3,4] Empty)
-}
