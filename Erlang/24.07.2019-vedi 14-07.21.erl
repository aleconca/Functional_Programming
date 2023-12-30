%Define a master process which takes a list of nullary (or 0-arity) functions, and starts a worker process for
%each of them. The master must monitor all the workers and, if one fails for some reason, must re-start it to
%run the same code as before. The master ends when all the workers are done.

%Note: for simplicity, you can use the library function spawn_link/1, which takes a lambda function, and
%spawns and links a process running it.

listlink([], Pids) -> Pids;
listlink([F|Fs], Pids) ->
  Pid = spawn_link(F),
  listlink(Fs, Pids#{Pid => F}).

master(Functions) ->
  process_flag(trap_exit, true),
  Workers = listlink(Functions, #{}),
  master_loop(Workers, length(Functions)).

master_loop(Workers, Count) ->
  receive
    {'EXIT', Child, normal} ->
    if
      Count =:= 1 -> ok;
      true -> master_loop(Workers, Count-1)
    end;
  {'EXIT', Child, _} ->
  #{Child := Fun} = Workers,
  Pid = spawn_link(Fun),
  master_loop(Workers#{Pid => Fun}, Count)
  end.
