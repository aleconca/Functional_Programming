{-
We want to implement a queue, i.e. a FIFO container with the two operations
enqueue and dequeue with the obvious meaning. A functional way of doing this is
based on the idea of using two lists, say L1 and L2, where the first one is used
for dequeuing (popping) and the second one is for enqueing (pushing) When
dequeing, if the first list is empty, we take the second one and put it in the
first, reversing it This last operation appears to be O(n), but suppose we
have n enqueues followed by n dequeues; the first dequeue takes time
proportional to n (reverse), but all the other dequeues take constant time.
This makes the operation O(1) amortised that is why it is acceptable in many
applications.

1) Define Queue and make it an instance of Eq
2) Define enqueue and dequeue, stating their types


HASKELL (ii)
Make Queue an instance of Functor and Foldable

HASKELL (iii)
Make Queue an instance of Applicative
-}
