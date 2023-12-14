{-
Consider the following data structure for general binary trees:

  data Tree a = Empty | Branch (Tree a) a (Tree a) deriving (Show, Eq)

Using the State monad as seen in class:

1) Define a monadic map for Tree, called mapTreeM.

2) Use mapTreeM to define a function which takes a tree and returns a tree containing list of elements 
that are all the data found in the original tree in a depth-first visit.

E.g.
From the tree: (Branch (Branch Empty 1 Empty) 2 (Branch (Branch Empty 3 Empty) 4 Empty))
we obtain:
Branch (Branch Empty [1] Empty) [1,2] (Branch (Branch Empty [1,2,3] Empty) [1,2,3,4] Empty)
-}


data Tree a = Empty | Branch (Tree a) a (Tree a) deriving (Show, Eq)




--1)  (>>=) :: m a -> (a -> m b) -> m b  
--instance Monad Tree where 
    --(Branch ls x rs) >>= f = 

mapTreeM :: Monad m => (t -> m a) -> Tree t -> m (Tree a)
mapTreeM f Empty = return Empty
mapTreeM f (Branch ls x rs) = do --iteratively apply the mapTreeM
                                ls' <- mapTreeM f ls  
                                x <- f v
                                rs' <- mapTreeM f rs
                                return (Branch ls' x rs') --Tree monad -> I can use return statement





--2)
depth_tree t = let (State f) = mapTreeM 
                                (\v -> do cur <- getState
                                          putState $ cur ++ [v]
                                          getState)
                                t
               in snd $ f []
{-
>mapTreeM: This is a higher-order function that takes a monadic function (\v -> ...) and a tree (t) 
and applies the monadic function to each element of the tree in a depth-first manner. 
It returns a monadic computation that represents the transformed tree.

>\v -> do cur <- getState ...: This is the monadic function passed to mapTreeM. For each element v in the tree, it does the following:

cur <- getState: Retrieves the current state (a list) using the getState function, which is presumably part of the State monad. 
The current state represents the elements collected so far during the tree traversal.

putState $ cur ++ [v]: Appends the current element v to the list cur and updates the state using putState. 
This effectively accumulates the elements in the state.

getState: Retrieves the updated state after appending v.

>State f = ...: The result of the mapTreeM operation is wrapped in the State monad. 
The f inside State f is the monadic computation that represents the transformed tree.--- Slide 108: In pratica coe fare (State f) = g Tree ,e poi (f []) = (final result, final State)                                          
The state within this monadic computation is a list that accumulates the elements.

>in snd $ f []: Extracts the state from the monadic computation f, i.e. the list, by initializing it with an empty list ([]) and using snd. 
This gives us the final state after the tree traversal. N.B. snd :: (a, b) -> b extracts second element of a Pair
-}
