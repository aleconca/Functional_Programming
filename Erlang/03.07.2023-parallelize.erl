%1. Define a “deep reverse” function, which takes a “deep” list, i.e. a list containing possibly lists of any
%depths, and returns its reverse.

%E.g. deeprev([1,2,[3,[4,5]],[6]]) is [[6],[[5,4],3],2,1].

%2. Define a parallel version of the previous function.

%1
deeprev([]) -> [];
deeprev([X|Xs]) -> V = deeprev(X),
    Vs = deeprev(Xs),
    Vs ++ [V];
deeprev(X) -> X. 


%2
deeprevp(L) ->
    P = self(),
    dp(P, L),
    receive
         {P, R} -> R %final result
    end.
     
dp(Pid, []) -> Pid ! {self(), []}; %base case
dp(Pid, [X|Xs]) -> 
    Self = self(),
    P1 = spawn(fun() -> dp(Self, X) end),
    P2 = spawn(fun() -> dp(Self, Xs) end),
    receive
        {P1, V} ->
        receive
            {P2, Vs} ->
            Pid ! {Self, Vs ++ [V]} %send final result
        end
    end;
dp(Pid, X) -> Pid ! {self(), X}. %send intermediate results 

    
