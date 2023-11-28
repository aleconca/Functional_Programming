{-
Define a partitioned list data structure, called Part, storing three elements:
1. a pivot value,
2. a list of elements that are all less than or equal to the pivot, and
3. a list of all the other elements.

Implement the following utility functions, writing their types:
• checkpart, which takes a Part and returns true if it is valid, false otherwise;
• part2list, which takes a Part and returns a list of all the elements in it;
• list2part, which takes a pivot value and a list, and returns a Part;

Make Part an instance of Foldable and Functor, if possible. If not, explain why.
-}

data Part a = Part [a] a [a] --no parentesi esterne perchè

checkpart :: Ord a => Part a -> Bool
checkpart (Part l p r) = null (filter (\x-> x>p) l) && null (filter (\x-> x<=p) r)

part2list :: Part a -> [a]
part2list (Part l p r) = l ++ [p] ++ r

list2part :: (Ord a) => a -> [a] -> Part a
list2part a l = l2ph a l [] [] where
 l2ph a [] l r = Part l a r
 l2ph a (x:xs) l r | x <= a = l2ph a xs (x:l) r --else
 l2ph a (x:xs) l r = l2ph a xs l (x:r)


instance Functor Part where
    fmap f (Part l p r) = (Part (fmap f l) (f p) (fmap f r))
    
--is not correct, because if we take e.g.
--p1 = Part [1,2,3] 4 [5,6,6]
--p2 = fmap (10 -) p1
--p2 is not a correct partition. We could use list2part to fix the solution, but this requires that, if f :: (a -> b), b must be
--an instance of Ord.
    

--instance Foldable Part where
    --foldr f z (Part l p r) = (foldr f (f (foldr f z l) p) r)
    
instance Foldable Part where
 foldr f i p = foldr f i (part2list p)
    
    
    
