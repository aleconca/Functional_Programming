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
gtree2list Tnil = []
gtree2list (Gtree x xs) = x : concatMap gtree2list xs
--gtree2list Gtree a [Gtree a] = [a] ++ gtree2list(Gtree a) ? No, come fai la ricorsione se 
--gtree2list prende un Gtree ? Oltretutto definizione sbagliata


instance Functor Gtree where
    fmap _ Tnil = Tnil
    fmap f (Gtree x xs) = Gtree (f x) (fmap f xs)
    --fmap f (Gtree x xs) = Gtree (f x) (fmap (fmap f) xs) ??


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

instance Foldable Gtree where
    foldr f z t = foldr f z $ gtree2list t --apply foldr to the final list given by gtree2list

Tnil +++ x = x
x +++ Tnil = x
(Gtree x xs) +++ (Gtree y ys) = Gtree y ( (Gtree x []:xs) ++ ys) -- foldr?

gtconcat v = foldr (+++) Tnil v
gtconcatMap f t = gtconcat $ fmap f t

instance Applicative Gtree where
    pure x = Gtree x []
    x <*> y = gtconcatMap (\f -> fmap f y) x 
    --ancora, perchè astrae dal costruttore?    




----

Tnil (+++) Tnil  = Gtree [] []
Tnil (+++) Gtree x xs = Gtree x xs
Gtree x xs (+++) Tnil = Gtree x xs
Gtree x xs (+++) Gtree y ys = Gtree (x:y) (xs ++ ys)

gtreeconcat lst = fmap (+++) Gtree lst
gtreecmap f flst = gtreeconcat $ fmap f flst

instance Applicative Gtree where
    pure v = Gtree v []
    (Gtree f fs)<*>(Gtree y ys) = Gtree (f y) (gtreecmap (\f -> fmap f ys) fs)


-----









