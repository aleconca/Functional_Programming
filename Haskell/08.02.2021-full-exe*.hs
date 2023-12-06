{-
A multi-valued map (Multimap) is a data structure that associates keys of
a type k to zero or more values of type v.  A Multimap can be represented as
a list of 'Multinodes', as defined below. Each multinode contains a unique key
and a non-empty list of values associated to it.

data Multinode k v = Multinode { key :: k
                               , values :: [v]
                               }

data Multimap k v = Multimap [Multinode k v]

1) Implement the following functions that manipulate a Multimap:

insert :: Eq k => k -> v -> Multimap k v -> Multimap k v
insert key val m returns a new Multimap identical to m, except val is added to the values associated to k.

lookup :: Eq k => k -> Multimap k v -> [v]
lookup key m returns the list of values associated to key in m

remove :: Eq v => v -> Multimap k v -> Multimap k v
remove val m returns a new Multimap identical to m, but without all values equal to val

2) Make Multimap k an instance of Functor.
-}

