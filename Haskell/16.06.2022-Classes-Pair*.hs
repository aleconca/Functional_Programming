{-
Consider the "fancy pair" data type (called Fpair), which encodes a pair of the same type a, and may
optionally have another component of some "showable" type b, e.g. the character '$'.
Define Fpair, parametric with respect to both a and b.

1) Make Fpair an instance of Show, where the implementation of show of a fancy pair e.g. encoding
(x, y, '$') must return the string "[x$y]", where x is the string representation of x and y of y. If the third
component is not available, the standard representation is "[x, y]".

2) Make Fpair an instance of Eq — of course the component of type b does not influence the actual
value, being only part of the representation, so pairs with different representations could be equal.

3) Make Fpair an instance of Functor, Applicative and Foldable.
-}


--1)
data Fpair s a = Fpair a a s | Pair a a

--2)
{- show :: (Show a) => a -> String-}
instance (Show a, Show s) => Show (Fpair s a) where
    show (Fpair x y t) = "[" ++ (show x) ++ (show t) ++ (show y) ++ "]"
    show (Pair x y) = "[" ++ (show x) ++ ", " ++ (show y) ++ "]"

--3)
{-
class Eq a where  
    (==) :: a -> a -> Bool  
    (/=) :: a -> a -> Bool  
    x == y = not (x /= y)  
    x /= y = not (x == y)  

When defining function bodies in the class declaration or when defining them in instance declarations, we can assume that a (concrete type) 
is a part of Eq and so we can use == on values of that type.

From the type declarations, we see that the a is used as a concrete type because all the types in functions have to be concrete 
(remember, you can't have a function of the type a -> Maybe but you can have a function of a -> Maybe a or Maybe Int -> Maybe String). 
That's why we can't do something like

instance Eq Maybe where  
    ...    
    
Because like we've seen, the a has to be a concrete type but Maybe isn't a concrete type. 
It's a type constructor that takes one parameter and then produces a concrete type. It would also be tedious to write instance Eq (Maybe Int) where, 
instance Eq (Maybe Char) where, etc. for every type ever. So we could write it out like so:

instance Eq (Maybe m) where . 

Thus:

instance Eq (Maybe m) where  
    Just x == Just y = x == y  
    Nothing == Nothing = True  
    _ == _ = False 
    
There's one problem with this though. Can you spot it? We use == on the contents of the Maybe but we have no assurance that what the Maybe contains 
can be used with Eq! That's why we have to modify our instance declaration like this: 

instance (Eq m) => Eq (Maybe m) where  
    Just x == Just y = x == y  
    Nothing == Nothing = True  
    _ == _ = False 
Take into account that the type you're trying to make an instance of will replace the parameter in the class declaration. The a from class Eq a where 
will be replaced with a real type when you make an instance, so try mentally putting your type into the function type declarations as well. 
(==) :: Maybe -> Maybe -> Bool doesn't make much sense but (==) :: (Eq m) => Maybe m -> Maybe m -> Bool does. But this is just something to think about, 
because == will always have a type of (==) :: (Eq a) => a -> a -> Bool, no matter what instances we make.    
-}

--simplify (Fpair x y _) = (x, y)
--simplify (Pair x y) = (x, y)

--instance (Eq a) => Eq (Fpair s a) where
-- x == y = (simplify x) == (simplify y)


instance (Eq a) => Show (Eq s a) where --s does not influence the result so we can avoid adding it to the signature as (Eq s)
    (Fpair x y _) == (Fpair x y _) = x == x && y == y
    (Fpair x y _) == (Pair x y ) = x == x && y == y
    (Pair x y ) == (Fpair x y _) = x == x && y == y
    (Pair x y) == (Pair x y) = x == x && y == y


