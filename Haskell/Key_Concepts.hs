>Haskell is pure:
Haskell computations are purely functional, meaning that computations do not produce side-effects.









>Call-by-need:
In order to understand call-by-need we need to understand call-by-name first. In call-by-name, arguments in functions are evaluated in an outermost fashion, 
this means that functions are applied before their arguments are computed. This is called passing arguments 'by name'. In call-by-name when an arguments is not
used, it is never evaluated; if it is used several times, it is re-evaluated each time. 
Call-by-need is a memoized version of call-by-name, meaning that if an argument is needed several times, it is evaluated only once and stored for subsequent compuations.

In Haskell we have an explicit implementation of call-by-need, which is incorporated in the 'Delay' keyword. Delay promises to execute a compuation, moreover it caches 
the evaluation and stores it for subsequent computations. To force evaluation we 'seq' the evaluation.








>Currying: (also known as 'Shönfinkelisation' :) )
In Haskell functions have only one argument. Functions with more than one argument are curried. To better clarify this concept we consider this code in Scheme:

(define (sum-square x)
    (lambda(y) (+ (* x x) (* y y)))))

The signature becomes C->(C->C), where C is the Complex numbers' field (the one mainly used in Scheme), right associative. In Haskell every function is automatically curried.
(History corner: see logician Haskell Curry)

We say here that the lambdas in Haskell become: 
from
(lambda(x y)(+ 1 x y))
to
\x y -> 1+x+y










>Functions:

-Definition: Functions are defined through a series of equations;
ex.

1)inc n = n + 1

2)length :: [ Integer ] -> Integer
  length [] = 0
  length ( x : xs ) = 1 + length xs

this is also an example of pattern matching: arguments are matched with the right parts of equations, top to bottom; if the match succeeds, the function body is called.


-Polymorphism:
the previous definition of 'length' could work with any kind of lists, not just those made of integers; indeed, if we omit its type declaration, it is inferred 
by Haskell as having type

length :: [ a ] -> Integer

lower case letters are type variables, so [a] stands for a list of elements of type a, for any a.

ex. Map function:
map f [] = []
map f ( x : xs ) = f x : map f xs

to define f while calling the map we can use any (+ 1), (1 +), (+).


-Composition: '$' is used to do the standard function composition  (f.g)(x) is f(g(x)).










>Types:

-Static typing: we need to know the type of everything at compile time; '::' means 'has type'.

1.Sum Type (Union Type):

Example: data Bool = False | True

Explanation: In this example, you are defining a custom data type called Bool. This type has two data constructors: False and True. 
Bool is a sum type because it can have one of two possible values: False or True. It represents a logical value that can be either False or True.

2.Product Type (Struct-Like Type):

Example: data Pnt a = Pnt a a

Explanation: In this example, you are defining a custom data type called Pnt (short for "point"). 
It is a product type because it represents a structure that contains two values of type a. The data constructor for this type is also named Pnt. 
You can create values of the Pnt type by applying the data constructor with two values of type a. For example, Pnt 2.3 5.7 creates a value of type Pnt Double.
It's important to note that data constructors and type constructors live in separate namespaces. Data constructors are used to create values, while type constructors 
are used to define new types. The type constructor Pnt is used to define the new type Pnt a, and the data constructor Pnt is used to create values of that type.


-Recursive: 
Classical recursive **type** example:

data Tree a = Leaf a | Branch ( Tree a ) ( Tree a )

e.g. **data constructor** Branch has type:

Branch :: Tree a -> Tree a -> Tree a

An example tree:

aTree = Branch ( Leaf ’a’) (Branch ( Leaf ’b’) ( Leaf ’c’) )

We know that Lists are recursive types. Thus:

data List a = Null | Cons a ( List a )

but Haskell has special syntax for them; in 'pseudo-Haskell':

data [ a ] = [] | a : [ a ]










>Infinite Lists:
Convenient syntax for creating infinite lists is e.g. ones before can be also written as [1,1..]. numsFrom 6 is the same as [6..].
We can create infinite lists also through list comprehension:
ex.
fib = 1 : 1 : [ a + b | (a , b ) <- zip fib ( tail fib )]
1 : 1 creates a list [1, 1], which represents the first two elements of the Fibonacci sequence.

[a + b | (a, b) <- zip fib (tail fib)] generates the rest of the Fibonacci sequence. It uses list comprehensions to calculate each element by adding the previous two elements. 
(a, b) are pattern-matched from the result of zip fib (tail fib), which pairs up elements of the fib list with its tail (everything except the first element). 
The comprehension generates a list of the sums.









>Patterns:
-Case:
    take m ys = case (m , ys ) of
    (0 , _ ) -> []
    (_ ,[]) -> []
    (n , x : xs ) -> x : take (n -1) xs

-If: 
    if <c> then <t> else <e>
    
-let and where:

    let x = 3
        y = 12
    in x + y -- = > 15
    
    where can be convenient to scope binding over equations, e.g.:
    
    powset set = powset ’ set [[]] where
    powset ’ [] out = out
    powset ’ ( e : set ) out = powset ’ set ( out ++ [ e : x | x <- out ])

Define a function called powset that computes the powerset of a given set. 
The powerset of a set is the set of all possible subsets of that set, including the empty set and the set itself. 

1.powset set = powset' set [[]]: This is the top-level definition of the powset function. It takes a single argument set and initializes the calculation by calling 
the helper function powset' with the set and an initial list containing an empty list [[]].

2.powset' [] out = out: This is the base case of the powset' function. When the input list set is empty, it returns the out value. In this context, 
out represents the intermediate result, which starts with a single empty list.

3.powset' (e : set) out = powset' set (out ++ [e : x | x <- out]): This is the recursive case of the powset' function. 
It takes the head e and the tail set of the input list and the current out list.

4.(e : x) constructs a new list by prepending the element e to each sublist x in the out list.
[e : x | x <- out] is a list comprehension that applies this construction to all sublists in the out list.
out ++ ... appends all the newly created sublists to the existing out list.
By using recursion, the powset' function progressively calculates the powerset of the input set set. The base case ensures that when the input set is empty, 
the calculation stops, and the result is returned.

5.use this powset function by passing a list of elements, and it will return the powerset of that list as a list of lists. For example: powset [1, 2, 3]
This call will return the powerset of the set [1, 2, 3].














>ADT (Abstract Data Type):
One main characteristic of ADT is that we can define an abstract 'interface' containing a coincise summary
of the imported functions without delving into their implementation. Therefore, we say that the representation type is hidden.

--TreeADT.hs
module TreeADT ( 
Tree , leaf , branch , cell ,
left , right , isLeaf 
) where

data Tree a -- just the type name
leaf :: a -> Tree a --signatures
branch :: Tree a -> Tree a -> Tree a
cell :: Tree a -> a
left , right :: Tree a -> Tree a
isLeaf :: Tree a -> Bool


--actual implementation in Main.hs
import TreeADT

data Tree a = Leaf a | Branch ( Tree a ) ( Tree a )

leaf = Leaf
branch = Branch
cell ( Leaf a ) = a
left ( Branch l r ) = l
right ( Branch l r ) = r
isLeaf ( Leaf _ ) = True
isLeaf _ = False











>Type classes:
In Haskell, type classes provide a way to define sets of operations that can be implemented by multiple types.

-Eq:
class Eq a where
     (==) :: a -> a -> Bool

Then we can provide multiple implementations by defining instances :
instance Eq Int where
     x==y = x Prelude.==y

or:
instance (Eq a) => Eq (Tree a) where
    -- type a must support equality as well
    Leaf a == Leaf b = a == b
    (Branch l1 r1) == (Branch l2 r2) = (l1==l2) && (r1==r2)
     _ == _ = False

 
-Ord:
we can also extend Eq with comparison operations:

class (Eq a) => Ord a where
    (<), (<=), (>=), (>) :: a -> a -> Bool
    max, min :: a -> a -> a

Can do the same with other classes
-Num:
Numeric types in the prelude include Int, Integers and Rationals. They come with predefined instances of the class Num.
The Num class implements the standard numeric operations. When you use numeric literals or values of type Int,Integer, etc., 
you can directly apply numeric operations without explicitly define instaances.

-Show:
instance Show (a -> b) where
   show f = "<< a function >>"

or:
instance Show a => Show (Tree a) where
    show (Leaf a) = show a
    show (Branch x y) = "<" ++ show x ++ " | " ++ show y ++ ">"








    
>Deriving:
usually it is not necessary to explicitly define instances of some classes, e.g.Eq and Show.
Haskell can be quite smart and do it automatically, by using deriving keyword.

infixr 5 :^:
data Tr a = Lf a | Tr a :^: Tr aderiving (Show, Eq)













>Foldable: foldl, foldr
>Functor: Trees
>Applicative: Lists, Trees
-Applicative Functors: Maybe
>Monads: State, Trees, Lists















>I/O:
main is the default entry point of the program (like in C)
    main = do {
    putStr "Please, tell me something>";
    thing <- getLine;
    putStrLn $ "You told me \"" ++ thing ++ "\".";
    }

>Exceptions:
We can read a file:

import System.IO
import System.Environment
    readfile = do {
    args <- getArgs; -- command line arguments
    handle <- openFile (head args) ReadMode;
    contents <- hGetContents handle; -- note: lazy
    putStr contents;
    hClose handle;
    }
main = readfile

and we can catch exceptions:

import Control.Exception
import System.IO.Error
...
main = handle handler readfile
    where handler e
        | isDoesNotExistError e =
        putStrLn "This file does not exist."
        | otherwise =
        putStrLn "Something is wrong."











>Classical Data Structures: 

-arrays:
import Data.Array
exarr = let m = listArray (1,3) ["alpha","beta","gamma"]
            n = m // [(2,"Beta")]
            o = n // [(1,"Alpha"), (3,"Gamma")]
            in (m ! 1, n ! 2, o ! 1)
            
exarr evaluates to ("alpha","Beta","Alpha").

-hash-tables;

-maps:
import Data.Map
exmap = let m = fromList [("nose", 11), ("emerald", 27)]
            n = insert "rug" 98 m
            o = insert "nose" 9 n
            in (m ! "emerald", n ! "rug", o ! "nose")
            
exmap evaluates to (27,98,9).


























