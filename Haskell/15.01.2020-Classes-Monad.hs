{-
The following data structure represents a cash register. As it should be clear from the two accessor
functions, the first component represents the current item, while the second component is used to store
the price (not necessarily of the item: it could be used for the total).

data CashRegister a = CashRegister { getReceipt :: (a, Float) } deriving (Show, Eq)

getCurrentItem = fst . getReceipt
getPrice = snd . getReceipt

1) Make CashRegister an instance of Functor and Applicative.

2) Make CashRegister an instance of Monad.
-}



--1)
instance Functor CashRegister where
    fmap f xs = CashRegister (f $ getCurrentItem xs, getPrice xs)

instance Applicative CashRegister where
    pure x = CashRegister (x, 0.0)
    CashRegister (f, pf) <*> CashRegister (x, px) = CashRegister (f x, pf + px)

--2)
-- >>= :: m a -> (a -> m b) -> m b, m in questo caso è CashRegister come istanza di Monad, 
-- quindi quando crei m b da restituire (ossia Cashregister (getCurrentItem newReceipt, price + (getPrice newReceipt)) ) 
-- usi le get perchè agisci su un tipo cashRegister ottenuto dopo aver applicato f ad oldItem (a -> m b).
-- In sintesi, f oldItam restituisce un Cashregister dal quale estrarre i valori finali con le get.
instance Monad CashRegister where
    CashRegister (oldItem, price) >>= f = let newReceipt = f oldItem
                                          in CashRegister (getCurrentItem newReceipt, price + (getPrice newReceipt))
