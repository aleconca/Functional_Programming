%1) Define a split function, which takes a list and a number n and returns a pair of lists, where the first one
%is the prefix of the given list, and the second one is the suffix of the list of length n.

%E.g. split([1,2,3,4,5], 2) is {[1,2,3],[4,5]}.

%2) Using split of 1), define a splitmap function which takes a function f, a list L, and a value n, and splits
%L with parameter n, then launches two process to map f on each one of the two lists resulting from the
%split. The function splitmap must return a pair with the two mapped lists.

helper(E, {0, L}) ->
    {-1, [[E]|L]}; %when N=0, stop-> end up having L! in the car and L2 in the cdr
helper(E, {V, [X|Xs]}) ->
    {V-1, [[E|X]|Xs]}. %split until N, 

split(L, N) ->
    {_, R} = lists:foldr(fun helper/2, {N, [[]]}, L),
    R.

mapper(F, List, Who) ->
    Who ! {self(), lists:map(F, List)}.

splitmap(F, L, N) ->
    [L1, L2] = split(L, N),
    P1 = spawn(?MODULE, mapper, [F, L1, self()]),
    P2 = spawn(?MODULE, mapper, [F, L2, self()]),
    receive
        {P1, V1} ->
        receive {P2, V2} ->
            {V1, V2}
        end
    end.

