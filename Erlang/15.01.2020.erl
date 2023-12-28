%We want to implement something like Python’s range in Erlang, using processes.

%E.g.
R = range(1,5,1) % starting value, end value, step
next(R) % is 1
next(R) % is 2
…
next(R) % is 5
next(R) % is the atom stop_iteration

%Define range and next, where range creates a process that manages the iteration, and next a function that
%talks with it, asking the current value.


range(Start, Stop, Inc) ->
    spawn(?MODULE, ranger, [Start, End, Step]).
    
ranger(Current, End, Step) ->
    Self=self(),
    receive
        {next, P} -> if 
                        Start > End -> P ! stop_iteration;
                        true -> P ! {next, Current}, range(Current+Step, End, Step) ;
                     end;
    end.
    
next(Pid) ->
    Self=self(),
    Pid ! {next, Self},
    receive
        {next, V} -> V, Pid ! {next, Self}, next(Pid);
        stop_iteration -> ok
    end.
    
