{-
Consider a non-deterministic finite state automaton (NFSA) and assume that its states are values of a type
State defined in some way. An NFSA is encoded in Haskell through three functions:

i) transition :: Char → State → [State], i.e. the transition function.
ii) end :: State → Bool, i.e. a functions stating if a state is an accepting state (True) or not.
ii) start :: [State], which contains the list of starting states.

1) Define a data type suitable to encode the configuration of an NSFA.

2) Define the necessary functions (providing also all their types) that, given an automaton A (through
transition, end, and start) and a string s, can be used to check if A accepts s or not.
-}

--1)
--data NFSA a = NFSA [a] [a] --matrix filled with transition values if an arch exists
data Config = Config String [State] deriving (Show, Eq)

--2)
steps :: (Char -> State -> [State]) -> Config -> Bool
steps trans (Config "" confs) = not . null $ filter end confs
steps trans (Config (a:as) confs) = steps trans $ Config as (concatMap (trans a) confs)
