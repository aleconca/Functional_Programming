%We want to define a “dynamic list” data structure, where each element of the list is an actor storing a value. Such value can be of
%course read and set, and each get/set operation on the list can be performed in parallel.

%1) Define create_dlist, which takes a number n and returns a dynamic list of length n. You can assume that each element store the value 0 at start.
%2) Define the function dlist_to_list, which takes a dynamic list and returns a list of the contained values.
%2) Define a map for dynamic list. Of course this operation has side effects, since it changes the content of the list.
