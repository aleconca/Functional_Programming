{-Consider the binary tree data structure as seen in class.

1. Define a function btrees which takes a value x and returns an infinite list of binary trees, where:

  1. all the leaves contain x,
  2. each tree is complete,
  3. the first tree is a single leaf, and each tree has one level more than its previous one in the list.
  
2. Define an infinite list of binary trees, which is like the previous one, but the first leaf contains the integer 1,
and each subsequent tree contains leaves that have the value of the previous one incremented by one.
E.g. [Leaf 1, (Branch (Leaf 2)(Leaf 2), ...]

3. Define an infinite list containing the count of nodes of the trees in the infinite list of the previous point.
E.g. [1, 3, ...]

Write the signatures of all the functions you define.-}

data Tree a = Leaf a | Node (Tree a) (Tree a)


--1)
btrees :: a -> [Tree a]
btrees x = helper(Leaf x)  
            where helper tree =
                    tree : (helper (Node tree tree) )

--btrees x = Leaf x : [Node t t | t <- btrees x]        

--2)
fmap :: a -> b -> Tree a -> Tree b
fmap f (Leaf x) = (Leaf f x)
fmap  f (Node x y) = (Node (fmap f x) (fmap f y))

btrees2 :: a -> [Tree a]
btrees2 x = helper(Leaf x)  
            where helper tree =
                    tree : (helper (fmap (+1) (Node tree tree)) )


--3)
count x = 1 : [ v*2 + 1 | v <- count x ]
