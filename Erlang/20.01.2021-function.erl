%Define a function for a proxy used to avoid to send PIDs; the proxy must react to the following messages:

%- {remember, PID, Name}: associate the value Name with PID.

%- {question, Name, Data}: send a question message containing Data to the PID corresponding to the value Name (e.g. an atom), like in PID ! {question, Data}

%- {answer, Name, Data}: send an answer message containing Data to the PID corresponding to the value Name (e.g. an atom), like in PID ! {answer, Data}


proxy(Table) -> %Table is a map of key-value pairs
    receive
        {remember, PID, Name} -> 
            proxy(Table#{Name => PID}); %This is a map update expression. It modifies the map Table by adding or                            
                                        %updating a key-value pair where the key is the value of Name, and the value is the                      
                                        %value of PID. The Table#{Name => PID} syntax creates a new map with the specified update.
        {question, Name, Data} ->
            #{Name := Id} = Table,  %pattern match key-value in Table; '=' verifies that the right part has the structure of the map on the left
            Id ! {question, Data},
            proxy(Table);
        {answer, Name, Data} ->
            #{Name := Id} = Table,
            Id ! {answer, Data},
            proxy(Table)
    end.
