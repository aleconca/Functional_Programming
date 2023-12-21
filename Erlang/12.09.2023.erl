%Consider the infinite list of binary trees of Exercise 2: instead of infinite lists, we want to create processes which
%return the current element of the "virtual infinite list" with the message next, and terminate with the message stop.
%1. Define a function btrees to create a process corresponding to the infinite tree of Exercise 2.1.

%1. Define a function btrees which takes a value x and returns an infinite list of binary trees, where:

  %1. all the leaves contain x,
  %2. each tree is complete,
  %3. the first tree is a single leaf, and each tree has one level more than its previous one in the list.

data Tree a = Leaf a | Node (Tree a) (Tree a)

--1)
btrees :: a -> [Tree a]
btrees x = helper(Leaf x)  
           where helper tree =
                  tree : (helper (Node tree tree) )
                  


child(P,T) ->
    receive
        {next} -> T1 = {branch, T, T},
                        P ! T1,
                        child(P,T1);
        {terminate} -> T
    end.
    
helper(V,P) ->
    spawn(?MODULE, child, [Self,{leaf V}]).


              
%2. Define a function incbtrees to create a process corresponding to the infinite tree of Exercise 2.2.

%2. Define an infinite list of binary trees, which is like the previous one, but the first leaf contains the integer 1,
%and each subsequent tree contains leaves that have the value of the previous one incremented by one.
%E.g. [Leaf 1, (Branch (Leaf 2)(Leaf 2), ...]

fmap :: a -> b -> Tree a -> Tree b
fmap f (Leaf x) = (Leaf f x)
fmap  f (Node x y) = (Node (fmap f x) (fmap f y))

btrees2 :: a -> [Tree a]
btrees2 x = helper(Leaf x)  
            where helper tree =
                    tree : (helper (fmap (+1) (Node tree tree)) )




inctree({leaf, X}) ->
    {leaf, X+1};
inctree({branch, X, Y}) ->
    {branch, inctree(X), inctree(Y)}.
 
incbtrees_body(T, Pid) ->
 receive
     next -> T1 = inctree(T),
             T2 = {branch, T1, T1},
             Pid ! T2,
             incbtrees_body(T2, Pid);
    stop -> T
 end.
 
incbtrees(Pid) ->
 spawn(?MODULE, incbtrees_body, [{leaf, 0}, Pid]).



%Notes: for security reasons, processes must only answer to their creating process; to define trees, you can use
%suitable tuples with atoms as customary in Erlang (e.g. {branch, {leaf, 1}, {leaf, 1}}).


                  
                  
                  
