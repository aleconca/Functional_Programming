%We want to define a “dynamic list” data structure, where each element of the list is an actor storing a value. Such value can be of
%course read and set, and each get/set operation on the list can be performed in parallel.

%1) Define create_dlist, which takes a number n and returns a dynamic list of length n. You can assume that each element store the value 0 at start.
%2) Define the function dlist_to_list, which takes a dynamic list and returns a list of the contained values.
%3) Define a map for dynamic list. Of course this operation has side effects, since it changes the content of the list.


cell(Value) ->
    receive
        {set, V} -> cell(V);
        {get, Pid} -> Pid ! Value, cell(Value)
    end.

delement_get(Element) -> 
    Element ! {get, self()},
    receive
        V -> V
    end.
    
delement_set(Element, New) ->
    Element ! {set, New}.
    %create_dlist(0) -> [];

create_dlist(Size) -> [spawn(?MODULE, cell, [0]) | create_dlist(Size-1)].

dlist_map([], _) -> ok;
dlist_map([X|Xs], Fun) ->
    delement_set(X, Fun(delement_get(X))),
    dlist_map(Xs, Fun).




%%%%


run(D) ->
    receive
        {get,P} -> P ! D, run(D);
        {set, V} -> run(V)
    end.
    
    
create_dlist(N) ->
    DList = [spawn(?MODULE, run, [0]) || _ <- lists:seq(1,N)]

dlist_to_list(DList) ->
   Values = [ P ! {get, self()} ||P <- DList],
   
map(DList,F) ->
    New = [ P ! {set, F(V)} || V <- dlist_to_list(DList) , P <- DList]. %cosi non modifico la lista originale


      
