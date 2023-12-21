%Define a "broadcaster" process which answers to the following
%commands:

%- {spawn, L, V} creates a process for each element of L, passing its
%initial parameter in V, where L is a list of names of functions
%defined in the current module and V is their respective parameters (of
%course it must be |L| = |V|);

%- {send, V}, with V a list of values, sends to each respective process
%created with the previous spawn command a message in V; e.g. {spawn,
%[1,2,3]} will send 1 to the first process, 2 to the second, and 3 to
%the third;

%- stop is used to end the broadcaster, and to also stop every process
%spawned by it.


broadcaster(Pids) -> 
    receive 
        {spawn, L, V} -> R = [ spawn(?MODULE,X,[Y]) || X <- L, Y <- V],
                         broadcaster(R);
        {send, V} -> [ X ! Y || X <- Pids, Y <- V]
        stop -> ok.
    end.
