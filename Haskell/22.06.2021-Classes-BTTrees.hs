{-
Define a data-type called BTT which implements trees that can be binary or ternary, and where every
node contains a value, but the empty tree (Nil). Note: there must not be unary nodes, like leaves.
1) Make BTT an instance of Functor and Foldable.
2) Define a concatenation for BTT, with the following constraints:
• If one of the operands is a binary node, such node must become ternary, and the other operand
will become the added subtree (e.g. if the binary node is the left operand, the rightmost node of
the new ternary node will be the right operand).
• If both the operands are ternary nodes, the right operand must be appened on the right of the left
operand, by recursively calling concatenation.

3) Make BTT an instance of Applicative.
-}
