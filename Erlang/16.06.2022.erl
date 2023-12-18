%Define a program tripart which takes a list, two values x and y, with x < y, and three functions, taking
%one argument which must be a list.

%• tripart first partitions the list in three sublists, one containing values that are less than both x and
%y, one containing values v such that x ≤ v ≤ y, and one containing values that are greater than both
%x and y.

%• Three processes are then spawned in parallel, running the three given functions and passing the
%three sublists in order (i.e. the first function must work on the first sublist and so on).

%• Lastly, the program must wait the termination of the three processes in the spawning order,
%assuming that each one will return the pair {P, V}, where P is its PID and V the resulting value.

%• tripart must return the three resulting values in a list, with the resulting values in the same order
%as the corresponding sublists.



helper([X|L],P1,P2,L1,L2,L3) when (X < P1) and (X < P2) -> helper(L,P1,P2,[X|L1],L2,L3);
helper([X|L],P1,P2,L1,L2,L3) when (X >= P1) and (X =< P2) -> helper(L,P1,P2,L1,[X|L2],L3);
helper([X|L],P1,P2,L1,L2,L3) when (X > P1) and (X > P2) -> helper(L,P1,P2,L1,L2,[X|L3]);
helper([],_,_,L1,L2,L3) -> [L1,L2,L3].

part(L,X,Y) -> helper(L,X,Y,[],[],[]).

tripart(L,X,Y,F1,F2,F3) ->
    [D1,D2,D3] = part(L,X,Y),
    
    P1 = spawn(?MODULE, F1, [D1]),
    P2 = spawn(?MODULE, F2, [D2]),
    P3 = spawn(?MODULE, F3, [D3]),
 
    receive
        {P1, V1} ->
        receive
            {P2, V2} ->
            receive
                {P3, V3} -> [V1,V2,V3]
            end
        end
    end.
    
    

%Another:
tripart(L,x,y,F1,F2,F3) when x < y ->
    %Helper(V) when V < Y, V < X -> V end. ERROR, shoul dreturn T/F but it could simply be jumped
    %Sub1 = [F(V) || V <- L, helper(V) ],
    %Sub1 = [ fun(V) when V < y and V < x -> V end.|| V <- L], ERROR
    Sub1 = [ V || V <- L, V < x, V < y ],  
    Sub2 = [ V || V <- L, x < V < y ],
    Sub3 = [ V || V <- L, V > y, V > x ],
    %fine but not so efficient
    
    P1 = spawn(?MODULE, F1, [Sub1]),
    P2 = spawn(?MODULE, F2, [Sub2]),
    P3 = spawn(?MODULE, F3, [Sub3]),
    
    receive
        {P1,V1} ->
        receive
            {P2,V2} ->
            receive
                {P3,V3} -> [V1, V2, V3]
            end.
        end.
    end.
    
