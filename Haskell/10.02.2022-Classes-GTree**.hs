{-
Consider a data structure Gtree for general trees, i.e. trees containg some data in each node, and a
variable number of children.
1. Define the Gtree data structure.
2. Define gtree2list, i.e. a function which translates a Gtree to a list.
3. Make Gtree an instance of Functor, Foldable, and Applicative.
-}


data Gtree a = Tnil | Gtree a [Gtree a] 
--Tnil represents an empty node or leaf with no data.
--Gtree a [Gtree a] represents a node containing data of type a and a list of child trees (each of type Gtree a).

gtree2list :: Gtree a -> [a]
gtree2list Gnil = [] 
gtree2list (Gtree x lst) =  x : concatMap gtree2list lst --concatMap per [3 [5 [Nil]]]; include una foldr (++) [] l


instance Functor Gtree where 
    fmap f Gnil = Gnil
    fmap f (Gtree x lst) = Gtree (f x) (map (fmap f) lst) --no concatMap: problemi tipi, ho Gtree non liste come sopra
                                                          --map per lista, fmap per Gtree


{-
class Foldable t where
    foldMap :: Monoid m => t m -> m
    foldr :: (a -> b -> b) -> b -> t a -> b
    foldl :: (b -> a -> b) -> b -> t a -> b
    
-(a -> b -> b): This is the folding function that takes an element of type a, an accumulator of type b, and produces a new accumulator of type b. This function is applied to each element of the list during the folding process.

-b: This is the initial (or "seed") value of the accumulator. It's the starting value for the folding process.

-t a: This is the list of elements to be folded.

-b: This is the final result of the folding process.    
-}    

--foldr :: (a -> b -> b) -> b -> Gtree a -> b
instance Foldable Gtree where
    foldr f z g = foldr f z (gtree2list g)


-- +++ :: Gtree a -> Gtree a -> Gtree a  
Gnil+++(Gtree x xs) = Gtree x xs --Gnil+++x = x
(Gtree x xs)+++Gnil = Gtree x xs --x+++Gnil = x
--Gnil+++Gnil = Gnil
x+++(Gtree y ys) = Gtree y ([x]++ys)

concatGtree g = foldr (+++) Gnil g          --operatore +++
concatmapGtree f xs = concatGtree (fmap f xs)
  
    
instance Applicative Gtree where
    --pure :: a -> Gtree a
    pure v = Gtree v [] 
    --<*> :: Gtree (a -> b) -> Gtree a -> Gtree b
    xs<*>x = concatmapGtree (\f -> fmap f x) xs
    
--data Listaf (a->b) = [(a->b)]   
