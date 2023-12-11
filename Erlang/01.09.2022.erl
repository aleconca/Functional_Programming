%We want to implement a parallel foldl, parfold(F, L, N), where the binary operator F is associative, and N
%is the number of parallel processes in which to split the evaluation of the fold. Being F associative,
%parfold can evaluate foldl on the N partitions of L in parallel. Notice that there is no starting (or
%accumulating) value, differently from the standard foldl.
%You may use the following libray functions:

%lists:foldl(<function>, <starting value>, <list>)
%lists:sublist(<list>, <init>, <length>), which returns the sublist of <list> starting at position

%<init> and of length <length>, where the first position of a list is 1.
