{-
Consider a data type PriceList that represents a list of items, where each item is associated with a price,
of type Float:
data PriceList a = PriceList [(a, Float)]
1) Make PriceList an instance of Functor and Foldable.
2) Make PriceList an instance of Applicative, with the constraint that each application of a function in the
left hand side of a <*> must increment a right hand side value’s price by the price associated with the
function.
E.g. PriceList [(("nice "++), 0.5), (("good "++), 0.4)] <*>
PriceList [("pen", 4.5), ("pencil", 2.8), ("rubber", 0.8)]
is
PriceList [("nice pen",5.0),("nice pencil",3.3),("nice rubber",1.3),("good pen",4.9),
("good pencil",3.2),("good rubber",1.2)]
-}
