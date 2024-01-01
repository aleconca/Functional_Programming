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

--String: Represents the remaining input string. As the NFSA processes the input, the remaining input string is updated accordingly.

--[State]: Represents the list of current states at that configuration. In an NFSA, there can be multiple possible states the automaton can be in at a given point. 
--The list captures this non-deterministic aspect.

--2)
steps :: (Char -> State -> [State]) -> Config -> Bool
steps trans (Config "" confs) = not . null $ filter end confs
steps trans (Config (a:as) confs) = steps trans $ Config as (concatMap (trans a) confs)

--If the remaining input string is empty (""), it checks if any of the current states (confs) satisfy the end condition 
--(i.e., if at least one state is an accepting state). It uses filter end confs to get a list of states that are accepting, 
--and then null checks if the list is empty. The result is negated (not) to return True if there is at least one accepting state, and False otherwise.

--If there is still input remaining (the string is not empty), it recursively calls steps with the following arguments:
--trans: The transition function.
--Config as (concatMap (trans a) confs): A new configuration where:
  --as is the remaining input string after consuming the first character (a).
  --concatMap (trans a) confs applies the transition function to each current state (confs) with the input character a. It concatenates the resulting lists of next states.

