>Haskell is pure:
Haskell computations are purely functional, meaning that computations do not produce side-effects.






>Call-by-need:
In order to understand call-by-need we need to understand call-by-name first. In call-by-name, arguments in functions are evaluated in an outermost fashion, 
this means that functions are applied before their arguments are computed. This is called passing arguments 'by name'. In call-by-name when an arguments is not
used, it is never evaluated; if it is used several times, it is re-evaluated each time. 
Call-by-need is a memoized version of call-by-name, meaning that if an argument is needed several times, it is evaluated only once and stored for subsequent compuations.

In Haskell we have an explicit implementation of call-by-need, which is incorporated in the 'Delay' keyword. Delay promises to execute a compuation, moreover it caches 
the evaluation and stores it for subsequent computations. To force evaluation we 'Force' the evaluation.






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
--inc n = n + 1
length :: [ Integer ] -> Integer
length [] = 0
length ( x : xs ) = 1 + length xs

this is also an example of pattern matching: arguments are matched with the right parts of equations, top to bottom; if the match succeeds, the function body is called.

-Polymorphism:
the previous definition of 'length' could work with any kind of lists, not just those made of integers; indeed, if we omit its type declaration, it is inferred 
by Haskell as having type

length :: [ a ] -> Integer

lower case letters are type variables, so [a] stands for a list of elements of type a, for any a.

-Composition: '$'







>Types:

-Static typing: we need to know the type of everything at compile time; '::' means 'has type'.

-User defined: 
-Recursive:Lists









>Infinite Lists:







>Patterns:
-Case
-If
-let and where








>ADT:









>Type classes:
-Eq
-Ord
-Num
-Show
>Deriving








>Defining Instances:








>Foldable: foldl, foldr
>Functor: Trees
>Applicative: Lists, Trees
-Applicative Functors: Maybe
>Monads: State, Trees, Lists








>I/O:
>Exceptions:










>Classical Data Structures: 
-arrays
-hash-tables
-maps

























