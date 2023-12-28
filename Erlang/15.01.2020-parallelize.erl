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
    spawn(?MODULE, ranger, [Start, End, Step]). % * when called it returns a Pid that I give as argument to next when I call it
    
ranger(Current, End, Step) ->
    Self=self(),
    receive
        {next, P} -> if 
                        Start > End -> P ! stop_iteration;
                        true -> P ! {next, Current}, range(Current+Step, End, Step) ;
                     end
    end.
    
next(Pid) -> %no need to receive the Pid through messages because of *
    Self=self(),
    Pid ! {next, Self},
    receive
        {next, V} -> V, next(Pid); % I just assume to ask for the next value when I call next, no need to keep sending messages automatically
        stop_iteration -> io:format("stop iterations") % I shoud at least know to stop
    end.
    
