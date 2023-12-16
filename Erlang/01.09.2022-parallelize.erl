%We want to implement a parallel foldl, parfold(F, L, N), where the binary operator F is associative, and N
%is the number of parallel processes in which to split the evaluation of the fold. Being F associative,
%parfold can evaluate foldl on the N partitions of L in parallel. Notice that there is no starting (or
%accumulating) value, differently from the standard foldl.

%You may use the following libray functions:
%lists:foldl(<function>, <starting value>, <list>)
%lists:sublist(<list>, <init>, <length>), which returns the sublist of <list> starting at position
%<init> and of length <length>, where the first position of a list is 1.

partition(L,Init,N,Acc) when length(L) > length(L) div N ->
    Acc=Acc++[lists:sublist(L, Init, length(L) div N],
    partition(L, Init+(length(L) div N), N, Acc).
partition(L,Init,N,Acc) -> Acc++[lists:sublist(L, Init, length(L)-Init)].    

job(Parent, F, [X|Xs]) ->
    Self=self(),
    V=lists:foldl(F,X,Xs),
    Parent ! {result,Self,V}

parfold(F, L, N) -> 
    Result = partition(L,1,N,[]),
    Self=self(),
    Plist = [spawn(?MODULE, job, [Self,F,X]) || X <- Result],
    [X|Xs] = [receive
                {result,P,V} -> V
              end || P <- Plist ],
    list:foldl(F, X, Xs).
    
