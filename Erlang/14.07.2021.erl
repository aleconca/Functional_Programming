%Consider a main process which takes two lists: one of function names, and one of lists of parameters (the
%first element of with contains the parameters for the first function, and so forth). 

%For each function, the main process must spawn a worker process, passing to it the corresponding argument list. 

%If one of the workers fails for some reason, the main process must create another worker running the same function.

%The main process ends when all the workers are done.

listmlink([], [], Pids) -> Pids; %to do Pattern Matchong we must be able to create the list of Workers as a Map
listmlink([F|Fs], [D|Ds], Pids) ->
   Pid = spawn_link(?MODULE, F, D),
   listmlink(Fs, Ds, Pids#{Pid => {F,D}}).%add Pid to map with associated F and D

master(Functions, Arguments) ->
   process_flag(trap_exit, true),
   Workers = listmlink(Functions, Arguments, #{}), %initial empty map
   master_loop(Workers, length(Functions)).%call master to wait for messages; #functions = #processes to manage

master_loop(Workers, Count) ->
 receive
   {'EXIT', _, normal} ->
       if
         Count =:= 1 -> ok;%base case to exit
         true -> master_loop(Workers, Count-1)%decrement until 1 Pid reamins in the Map
       end;
   {'EXIT', Child, _} ->
       #{Child := {F,D}} = Workers, %Pattern Matching to extract parameters
       Pid = spawn_link(?MODULE, F, D), %spawn process again
       master_loop(Workers#{Pid => {F,D}}, Count) %keep loop active
 end.














%First attempt
main(Fs,Ps) -> 
    Self=self(),
    %A process is created by calling spawn:
    %spawn(Module, Name, Args) -> pid()
    Workers = [spawn(?MODULE, F , [X]) || X <- Ps, F <- Fs],
    %The default behaviour when a process receives an exit signal with an exit reason other than normal, is to terminate and in turn emit exit signals with the same exit reason to its linked processes. An exit signal with reason normal is ignored.
    %When a process is trapping exits, it will not terminate when an exit signal is received. Instead, the signal is transformed into a message {'EXIT',FromPid,Reason} which is put into the mailbox of the process just like a regular message.
    [receive
        {'EXIT', Worker, _ } -> %#{Worker := {F,X}} = Workers, but Workers should be a map
                                 spawn_link(?MODULE, , ),
        {'EXIT', _, normal} -> ok.
     end.
    || W <- Workers],
    
    exit(_).
    
