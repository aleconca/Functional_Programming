%Define a process P, having a local behavior (a function), that answer to three commands:

%- load is used to load a new function f on P: the previous behavior is composed with f;
%- run is used to send some data D to P: P returns its behavior applied to D;
%- stop is used to stop P.

%For security reasons, the process must only work with messages coming from its creator: other messages
%must be discarded.
