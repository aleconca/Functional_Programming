%Define a function create_pipe, which takes a list of names and creates a process of each element of the list,
%each process registered as its name in the list; e.g. with [one, two], it creates two processes called ‘one’ and
%‘two’. The processes are “connected” (like in a list, there is the concept of “next process”) from the last to
%the first, e.g. with [one, two, three], the process structure is the following:

%three → two → one → self,

%this means that the next process of ‘three’ is ‘two’, and so on; self is the process that called create_pipe.
%Each process is a simple repeater, showing on the screen its name and the received message, then sends it to
%the next process.
%Each process ends after receiving the ‘kill’ message, unregistering itself.
