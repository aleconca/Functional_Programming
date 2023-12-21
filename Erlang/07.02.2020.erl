%We want to create a simplified implementation of the “Reduce” part of the MapReduce paradigm. To this
%end, define a process “reduce_manager” that keeps track of a pool of reducers. When it is created, it
%stores a user-defined associative binary function ReduceF. It receives messages of the form {reduce,
%Key, Value}, and forwards them to a different “reducer” process for each key, which is created lazily
%(i.e. only when needed). Each reducer serves requests for a unique key.
%Reducers keep into an accumulator variable the result of the application of ReduceF to the values they
%receive. When they receive a new value, they apply ReduceF to the accumulator and the new value,
%updating the former. When the reduce_manager receives the message print_results, it makes all its
%reducers print their key and incremental result.

%For example, the following code (where the meaning of string:split should be clear from the context):

word_count(Text) ->
RMPid = start_reduce_mgr(fun (X, Y) -> X + Y end),
lists:foreach(fun (Word) -> RMPid ! {reduce, Word, 1} end, string:split(Text, " ", all)),
RMPid ! print_results,
ok.

%causes the following print:
1> mapreduce:word_count("sopra la panca la capra campa sotto la panca la capra crepa").
sopra: 1
la: 4
panca: 2
capra: 2
campa: 1
sotto: 1
crepa: 1
ok
