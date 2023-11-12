{-
We want to define a data structure for binary trees, called BBtree, where in each node are stored two values of the
same type. Write the following:

1. The BBtree data definition.

2. A function bb2list which takes a BBtree and returns a list with the contents of the tree.

3. Make BBtree an instance of Functor and Foldable.

4. Make BBtree an instance of Applicative, using a “zip-like” approach, i.e. every function in the first
argument of <*> will be applied only once to the corresponding element in the second argument of <*>.

5. Define a function bbmax, together with its signature, which returns the maximum element stored in the
BBtree, if present, or Nothing if the data structure is empty.
-}
