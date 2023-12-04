{-
We want to define a data structure for the tape of a Turing machine: Tape is a parametric data structure with
respect to the tape content, and must be made of three components:
1. the portion of the tape that is on the left of the head;
2. the symbol on which the head is positioned;
3. the portion of the tape that is on the right of the head.

Also, consider that the machine has a concept of "blank" symbols, so you need to add another component in the
data definition to store the symbol used to represent the blank in the parameter type.
1. Define Tape.
2. Make Tape an instance of Show and Eq, considering that two tapes contain the same values if their stored
values are the same and in the same order, regardless of the position of their heads.
3. Define the two functions left and right, to move the position of the head on the left and on the right.
4. Make Tape an instance of Functor and Applicative.
-}


--1)
data Tape a = Tape [a] a [a] a

--data Tape a b = Tape a (Tape a b) (Tape a b) | Blank b (Tape a b)


--2)
instance Eq a => Eq (Tape a) where
 (Tape x h y _) == (Tape x' h' y' _) = (x ++ [h] ++ y) == (x' ++ [h'] ++ y')

    
    
instance Show a => Show (Tape a) where
    Tape l h r b = show l ++ show h ++ show r 
 

--3)

left :: Tape a -> Tape a
left (Tape [] h r b) = Tape [] b ([h]++r) b
left (Tape (x:xs) h r b) = Tape xs x ([h]++r) b --Shouldn't I reverse the left part?

    
right :: Tape a -> Tape a  
right (Tape x h [] b) = Tape ([h]++l) b [] b
right (Tape l h (x:xs) b) = Tape ([h]++l) x xs b


--4) 
--fmap :: (a -> b) -> f a -> f b 
instance Functor Tape where
    fmap f (Tape l h r b) = Tape (fmap f l) (f h) (fmap f r) (f b)




--pure :: a -> f a  
--(<*>) :: f (a -> b) -> f a -> f b
instance Applicative Tape where
    pure x = Tape [] x [] x
 -- zipwise apply
    (Tape fl f fr fb) <*> (Tape l h r b) = Tape (zipApp fl l) (f h) (zipApp fr r) (fb b)
                                            where zipApp x y = [f x | (f,x) <- zip x y] --list comprehension
                                            -- fx=(f1,f2,f3) e x=Char allora [(f1,x),(f3,x),(f3,x)] ed applico f x se ho un pair (f,x) e return list
    
    

-- concatMap :: (a -> [b]) -> [a] -> [b]
-- (concatMap (\f -> fmap f xs) fx)  
    
    
    
    
    
    
