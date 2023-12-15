%Define a parallel lexer, which takes as input a string x and a chunk size n, and translates all the words in
%the strings to atoms, sending to each worker a chunk of x of size n (the last chunk could be shorter than
%n). You can assume that the words in the string are separated only by space characters (they can be more
%than one - the ASCII code for ' ' is 32); it is ok also to split words, if they overlap on different chunks.

%E.g.
% plex("this is a nice test", 6) returns [[this,i],[s,a,ni],[ce,te],[st]]

%For you convenience, you can use the library functions:
%• lists:sublist(List, Position, Size) which returns the sublist of List of size Size from position Position (starting at 1);
%• list_to_atom(Word) which translates the string Word into an atom


split(List, Size, Pos, End) when Pos < End ->
   [lists:sublist(List, Pos, Size)] ++ split(List, Size, Pos+Size, End); %include case where the last chunck isn't long                                                                   enough to produce a chiunck
split(_, _, _, _) -> [].


lex([X|Xs], []) when X =:= 32 -> % 32 is ' ', exactly equal to 32
    lex(Xs, []);
lex([X|Xs], Word) when X =:= 32 ->
    [list_to_atom(Word)] ++ lex(Xs, []);
lex([X|Xs], Word) ->
    lex(Xs, Word++[X]);
lex([], []) ->
    [];
lex([], Word) -> 
    [list_to_atom(Word)].
 
 
run(Pid, Data) ->
 Pid ! {self(), lex(Data, [])}.


plex(List, Size) ->
    Part = split(List, Size, 1, length(List)),
    W = lists:map( fun(X) -> 
                    spawn(?MODULE, run, [self(), X]) 
                   end, Part ),
    lists:map(fun (P) ->
              receive
                {P, V} -> V
              end
              end, W).

