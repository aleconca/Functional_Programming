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
    P = self(), %BIF that returns the Pid of the current process, 
    dp(P, L),
    receive
         {P, R} -> R %final result
    end.
     
dp(Pid, []) -> Pid ! {self(), []}; %base case
dp(Pid, [X|Xs]) -> 
    Self1 = self(), %BIF that returns the Pid of the current process, 
    P1 = spawn(fun() -> dp(Self1, X) end), %returns Pid of the spawned process
    P2 = spawn(fun() -> dp(Self1, Xs) end), %why don't we use MODULE?, because we are defining two lambdas? I wrap the call inside an anonymous function so 
                                            %it doesn't need arguments anymore. Calling spawn(?MODULE, dp, [Self, Xs]) would have done a similar job.
    receive
        {P1, V} ->
        receive
            {P2, Vs} ->
            Pid ! {Self1, Vs ++ [V]} %send final result to P
        end
    end;
dp(Pid, X) -> Pid ! {self(), X}. %send intermediate results to Self1

    
