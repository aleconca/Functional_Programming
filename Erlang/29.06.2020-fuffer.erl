%Define a "functional" process buffer, called fuffer, that stores only one value and may receive messages only from its creator. fuffer can receive the following commands:
%'set' to store a new value
%'get' to obtain the current value
%'apply F' to apply the function F to the stored value
%'die' to end
%'duplicate' to create (and return) an exact copy of itself


fuffer(Data, PID) ->
    receive
        {set, PID, V} ->
            fuffer(V, PID);
        {get, PID} ->
            PID ! Data, 
            fuffer(Data, PID);
        {apply, PID, F} ->
            fuffer(F(Data), PID);
        {die, PID} -> ok;
        {duplicate, PID} ->
            PID ! spawn(?MODULE, fuffer, [Data, PID]),
            fuffer(Data, PID)
    end.
