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

























