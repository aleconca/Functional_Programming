q0() ->
 receive
   {S, [a|Xs], [z|T]} -> q1 ! {S, Xs, [a,z] ++ T}
 end,
 q0().

q1() ->
 receive
   {S, [a|Xs], [a|T]} -> q1 ! {S, Xs, [a,a] ++ T};
   {S, [b|Xs], [a|T]} -> q2 ! {S, Xs, T}, q3 ! {S, Xs, [a|T]}
 end,
 q1().

q2() ->
 receive
   {S, [b|Xs], [a|T]} -> q2 ! {S, Xs, T};
   {S, Xs, [z|T]} -> q5 ! {S, Xs, T}
 end,
 q2().

q3() ->
 receive
   {S, [b|Xs], [a|T]} -> q4 ! {S, Xs, T}
 end,
 q3().

q4() ->
 receive
   {S, [b|Xs], [a|T]} -> q3 ! {S, Xs, [a|T]};
   {S, Xs, [z|T]} -> q5 ! {S, Xs, T}
 end,
 q4().

q5() ->
 receive
   {S, [], _} -> io:format("~w accepted~n", [S])
 end,
 q5().

start() ->
 register(q0, spawn(fun() -> q0() end)), % to avoid exporting qs
 register(q1, spawn(fun() -> q1() end)),
 register(q2, spawn(fun() -> q2() end)),
 register(q3, spawn(fun() -> q3() end)),
 register(q4, spawn(fun() -> q4() end)),
 register(q5, spawn(fun() -> q5() end)).

stop() ->
 unregister(q0),
 unregister(q1),
 unregister(q2),
 unregister(q3),
 unregister(q4),
 unregister(q5).

read_string(S) ->
 q0 ! {S, S, [z]}, ok.
