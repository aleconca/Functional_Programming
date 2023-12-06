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


--1)
insert :: Eq k => k -> v -> Multimap k v -> Multimap k v
insert key val (Multimap []) = Multimap [Multinode key [val]]
insert key val (Multimap (m@(Multinode nk nvals):ms))
  | nk == key = Multimap ((Multinode nk (val:nvals)):ms)
  | otherwise = let Multimap p = insert key val (Multimap ms)
                in Multimap (m:p)

                
lookup :: Eq k => k -> Multimap k v -> [v]
lookup key (Multimap []) = []
lookup key (Multimap (m@(Multinode nk nvals):ms))
  | nk == key = nvals
  | otherwise = lookup key (Multimap ms)
               
                
                
remove :: Eq v => v -> Multimap k v -> Multimap k v                
remove val (Multimap ms) = Multimap $ foldr mapfilter [] ms
  where mapfilter (Multinode nk nvals) rest =
          let filtered = filter (/= val) nvals
          in if null filtered
             then rest
             else (Multinode nk filtered):rest
                               
                
                
--2)
instance Functor Multimap where
    fmap f (Multimap m) = Multimap (fmap (mapNode f) m) 
                          where mapNode f (Multinode k v) = Multinode k (fmap f v)











                
