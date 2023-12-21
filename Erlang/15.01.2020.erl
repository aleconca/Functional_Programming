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
