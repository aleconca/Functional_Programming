%Define a parfind (parallel find) operation, which takes a list of lists L and a value x, and parallely looks for x in every list of L – the
%idea is to launch one process for each list, searching for x. If x is found, parfind returns one of the lists containing x; otherwise, it
%returns false.

%E.g. parfind([[1,2,3],[4,5,6],[4,5,9,10]], 4) could return either [4,5,6] or [4,5,9,10]; parfind([[1,2,3],[4,5,6],[4,5,9,10]], 7) is false.
