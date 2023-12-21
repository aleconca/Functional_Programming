%Consider the infinite list of binary trees of Exercise 2: instead of infinite lists, we want to create processes which
%return the current element of the "virtual infinite list" with the message next, and terminate with the message stop.
%1. Define a function btrees to create a process corresponding to the infinite tree of Exercise 2.1.
%2. Define a function incbtrees to create a process corresponding to the infinite tree of Exercise 2.2.
%Notes: for security reasons, processes must only answer to their creating process; to define trees, you can use
%suitable tuples with atoms as customary in Erlang (e.g. {branch, {leaf, 1}, {leaf, 1}}).


%1. Define a function btrees which takes a value x and returns an infinite list of binary trees, where:

  %1. all the leaves contain x,
  %2. each tree is complete,
  %3. the first tree is a single leaf, and each tree has one level more than its previous one in the list.

%data Tree a = Leaf a | Node (Tree a) (Tree a)

%--1)
%btrees :: a -> [Tree a]
%btrees x = helper(Leaf x)  
           % where helper tree =
                  %  tree : (helper (Node tree tree) )
