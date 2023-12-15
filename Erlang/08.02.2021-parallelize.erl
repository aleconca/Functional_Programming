%Consider the apply operation (i.e.<*>) in Haskell's Applicative class.
%Define a parallel <*> for Erlang's lists.

%class (Functor f) => Applicative f where  
    %pure :: a -> f a  
    %(<*>) :: f (a -> b) -> f a -> f b


runit(Proc, F, X) -> %Map
    Proc ! {self(), F(X)}.
    
pmap(F, L) ->
    W = lists:map(fun(X) -> 
                          spawn(?MODULE, runit, [self(), F, X]) 
                  end, L),
    lists:map(fun (P) -> %receive intermediate results
                      receive
                          {P, V} -> V %intermediate result to be concatenated
                      end
              end, W).

pappl(FL, L) ->
    lists:foldl(fun (X,Y) -> Y ++ X end, [], pmap( fun(F) -> pmap(F, L) end , FL)). %concat   

