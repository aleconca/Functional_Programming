%Define a parfind (parallel find) operation, which takes a list of lists L and a value x, and parallely looks for x in every list of L – the
%idea is to launch one process for each list, searching for x. If x is found, parfind returns one of the lists containing x; otherwise, it
%returns false.

%E.g. parfind([[1,2,3],[4,5,6],[4,5,9,10]], 4) could return either [4,5,6] or [4,5,9,10]; parfind([[1,2,3],[4,5,6],[4,5,9,10]], 7) is false.


lookup(L,X,S) ->
    [ if 
         V =:= X -> S ! L ;
         true -> false
      end
    || V <- L]    

parfind(Lists,X) ->
    Self = self(),
    [ spawn(?MODULE,lookup,[L,X,Self]) || L <- Lists],
    receive
        V -> V;
        false -> ok
    end.

%%%

worker(Dad, List, X) ->
    case lists:member(X, List) of
        true -> Dad ! {found, List};
        false -> Dad ! nay
    end.

get_result(0) -> false;
get_result(V) ->
    receive
        nay -> get_result(V-1);
        {found, L} -> L
    end.

parfind(LofL, X) ->
    lists:foreach(fun(L) -> spawn(?MODULE, worker, [self(), L, X]) end, LofL),
    get_result(length(LofL)).

%%%

