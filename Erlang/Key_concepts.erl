https://learnyousomeerlang.com/content
https://www.erlang.org/

>Variables:
Variables start with an Upper Case Letter (like in Prolog). Variables can only be bound once. The value of a variable can never be
changed once it has been set.

Examples:
Abc
A_long_variable_name
ACamelCaseVariableName







>Atoms:
Atoms are like symbols in Scheme. Any character code is allowed within an atom, singly quoted sequences of characters are atoms (not strings).
Unquoted must be lowercase, to avoid clashes with variables.

Examples:
abcef
start_with_a_lower_case_letter
’Blanks can be quoted’
’Anything inside quotes \n’


NOTE:

-Variables:
Variables are used to hold values.
They start with an uppercase letter or an underscore.
Once assigned a value, the value cannot be changed.
Variable = 42,

-Atoms (Symbols):
Atoms are constants, and they are often used to represent symbolic values.
Atoms are written in lowercase or with a single-quoted string.
They are used to represent names, labels, or unique identifiers.
'AtomWithSpaces',










  
>Tuples:
Tuples are used to store a fixed number of items.

Examples:
{123, bcd}
{123, def, abc}
{person, ’Jim’, ’Austrian’} % three atoms!
{abc, {def, 123}, jkl}

There is also the concept of record (struct), but in Erlang it is just special syntax for tuples.











>Lists:
Are like in Haskell, ex. [1, 2, 3], ++ concatenates. The main difference: [X | L] is cons (like (cons X L)).

Strings are lists, like in Haskell, but is getting common to use bitstrings and UTF.
In Erlang, a bitstring is a binary data type that represents a sequence of bits. It is a flexible data type used for handling binary data efficiently. 
Bitstrings are often used for operations that involve manipulating and processing binary data at a bit level. They can be created using the <<>> syntax.

Example:
Bits = <<1, 0, 1, 1, 0, 1, 0, 1>>.

In this example, Bits is a bitstring representing the binary sequence 10110101.
UTF (Unicode Transformation Format) is a character encoding standard that represents text in a form that can be used for processing and storage.

Comprehensions are more or less like in Haskell:

[{X,Y} || X <- [-1, 0, 1], Y <- [one, two, three], X >= 0].
[{0,one},{0,two},{0,three},{1,one},{1,two},{1,three}]











>Pattern Matching:
= is for pattern matching; _ is “don’t care”

A = 10
  Succeeds - binds A to 10

{A, A, B} = {abc, abc, foo}
  Succeeds - binds A to abc, B to foo
                             
{A, A, B} = {abc, def, 123}
  Fails
                               
[A,B|C] = [1,2,3,4,5,6,7]
  Succeeds - binds A = 1, B = 2, C = [3,4,5,6,7]
                                   
[H|T] = [abc]
  Succeeds - binds H = abc, T = []
                              
{A,_, [B|_], {B}} = {abc, 23, [22, x], {22}}
  Succeeds - binds A = abc, B = 22

The pattern matching behavior in Erlang is such that in the tuple pattern {A, A, B} = {abc, abc, foo}, 
it succeeds because it matches the elements in the tuple with the specified variables, and it allows variables to be repeated in the pattern. 
The matching process binds the variables to the corresponding values in the tuple.

{A, A, B} = {abc, abc, foo}.
-The tuple on the right is {abc, abc, foo}.
-The pattern on the left {A, A, B} is attempting to match the elements of the tuple.
-The first element A is matched with abc (success).
-The second element A is matched with the second element abc (success).
-The third element B is matched with the third element foo (success).

So, the overall pattern matching succeeds, and variables are bound accordingly. 
The repetition of the variable A in the pattern allows it to match the repeated values in the tuple.

Now, let's consider the case {A, A, B} = {abc, def, 123}:

-The tuple on the right is {abc, def, 123}.
-The pattern on the left {A, A, B} is attempting to match the elements of the tuple.
-The first element A is matched with abc (success).
-The second element A is attempting to match with the second element def, but it fails because A is already bound to abc. Pattern matching fails.

So, the overall pattern matching fails in the second case due to the attempt to bind the already bound variable A to a different value.







                              
>Maps:
There are maps, basically hash tables. Here are some examples:

> Map = #{one => 1, "Two" => 2, 3 => three}.
#{3 => three,one => 1,"Two" => 2}

> % update/insert
> Map#{one := "I"}.
#{3 => three,one => "I","Two" => 2}

> Map.
#{3 => three,one => 1,"Two" => 2} % unchanged

> % I want the value for "Two":
> #{"Two" := V} = Map.
#{3 => three,one => 1,"Two" => 2}
> V.
2










>Function Calls:
module:func(Arg1, Arg2, ... Argn)
func(Arg1, Arg2, .. Argn)

1. Function and module names (func and module in the above) must be atoms.
2. Functions are defined within Modules.
3. Functions must be exported before they can be called from outside the module where they are defined.
4. Use -import to avoid qualified names, but it is discouraged

>BIFs:
BIFs are in the erlang module. They do what you cannot do in Erlang, and are usually implemented in C:

date()
time()
length([1,2,3,4,5])
size({a,b,c})
atom_to_list(an_atom) % "an_atom"
list_to_tuple([1,2,3,4]) % {1,2,3,4}
integer_to_list(2234) % "2234"
tuple_to_list({}) 
...

>Function Syntax and Evaluation:
A function is defined as a sequence of clauses.

func(Pattern1, Pattern2, ...) -> ... ;
func(Pattern1, Pattern2, ...) -> ... ;
...
func(Pattern1, Pattern2, ...) -> ... .

Clauses are scanned sequentially until a match is found. When a match is found all variables occurring in the head become bound.
Variables are local to each clause, and are allocated and deallocated
automatically. The body is evaluated sequentially (use "," as separator).

Examples:
-module(mathStuff).
-export([factorial/1, area/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

area({square, Side}) ->
  Side * Side;
area({circle, Radius}) ->
  3.14 * Radius * Radius;
area({triangle, A, B, C}) ->
  S = (A + B + C)/2, 
  math:sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) -> {invalid_object, Other}.


>Guarded Functions:

factorial(0) -> 1;
factorial(N) when N > 0 ->
  N * factorial(N - 1).

The keyword when introduces a guard, like | in Haskell.

Examples of guards:

number(X) - X is a number
integer(X) - X is an integer
float(X) - X is a float
atom(X) - X is an atom
tuple(X) - X is a tuple
list(X) - X is a list
X > Y + Z - X is > Y + Z
X =:= Y - X is exactly equal to Y
X =/= Y - X is not exactly equal to Y
X == Y - X is equal to Y
(with int coerced to floats, i.e. 1 == 1.0 succeeds but 1 =:= 1.0 fails)
length(X) =:= 3 - X is a list of length 3
size(X) =:= 2 - X is a tuple of size 2.

All variables in a guard must be bound.

Other useful constructs:

case lists:member(a, X) of
  true -> ... ;
  false -> ...
end,

if
  integer(X) -> ... ;
  tuple(X) -> ... ;
  true -> ...  % works as an "else"
end,












>Apply:
apply(Mod, Func, Args)

1. Apply function Func in module Mod to the arguments in the list Args.
2. Mod and Func must be atoms (or expressions which evaluate to atoms).

apply(?MODULE, min_max, [[4,1,7,3,9,10]]).
{1, 10}

3. Any Erlang expression can be used in the arguments to apply.
4. ?MODULE uses the preprocessor to get the current module’s name









>Lambdas and hof:

Syntax for lambdas is: 

Square = fun (X) -> X*X end.

We can use it like this: Square(3).
Lambdas can be passed as usual to higher order functions:

lists:map(Square, [1,2,3]). 
%returns [1,4,9]

To pass standard ("non-lambda") functions, we need to prefix their name with 'fun' and state their arity:

lists:foldr(fun my_function/2, 0, [1,2,3]).











>Concurrency:

There are three main primitives:

1. spawn : creates a new process executing the specified function, returning an identifier;

we have a process with Pid1 (Process Identity or Pid) in it we perform:

Pid2 = spawn(Mod, Func, Args)

like apply but spawning a new process; after, Pid2 is the process identifier of the new process – this is known only to process Pid1.



2. ! : sends a message to a process through its identifier; the content of the message is simply a variable. The operation is asynchronous;

Process A sends a message to B (it uses self() to identify itself):

PidB ! {self(), foo}

{PidA, foo} is sent to process B

B receives it with:

receive
  {From, Msg} -> Actions
end

self() – returns the Pid of the process executing it
From and Msg become bound when the message is received.


3. receive ... end : extract, going from the first, a message from a process’s mailbox queue matching with the provided set of patterns – this is blocking if
no message is in the mailbox. The mailbox is persistent until the process quits.

A performs PidC ! foo
B performs PidC ! bar

code in C:

receive
  foo -> true
end,
receive
  bar -> true
end

foo is received, then bar, irrespective of the order in which they were sent.

A performs PidC ! foo
B performs PidC ! bar

code in C:

receive
  Msg -> ... ;
end

The first message to arrive at the process C will be processed – the variable Msg in the process C will be bound to one of the atoms foo or bar depending
on which arrives first.





We also have registred processes; register(Alias, Pid) Registers the process Pid with name Alias:

start() ->
  Pid = spawn(?MODULE, server, [])
  register(analyzer, Pid).

analyze(Seq) ->
  analyzer ! {self(), {analyze, Seq}},
  receive
    {analysis_result, R} -> R
  end.

Any process can send a message to a registered process.







>Client-Server Model:

-module(myserver).

server(Data) -> % note: local data
  receive
    {From,{request,X}} ->
    {R, Data1} = fn(X, Data),
    From ! {myserver,{reply, R}},
    server(Data1)
  end.

-export([request/1]).

request(Req) ->
  myserver ! {self(),{request,Req}},
    receive
    {myserver,{reply,Rep}} -> Rep
  end.




>Master-Slave Model:

Each worker has a state (a natural number, 0 at start), can receive messages with a number to add to it from the supervisor, and sends back its current
state. When its local value exceeds 30, a worker ends its activity.
The supervisor sends "add" messages to workers, and keeps track of how many of them are still active; when the last one ends, it terminates.
We are going to add code to simulate random errors in workers: the supervisor must keep track of such problems and re-start a new worker if one
is prematurely terminated.

main(Count) ->
  register(the_master, self()), % I’m the master, now
  start_master(Count),
  unregister(the_master),
  io:format("That’s all.~n").

start_master(Count) ->
% The master needs to trap exits:
  process_flag(trap_exit, true),
  create_children(Count),
  master_loop(Count).

% This creates the linked children
create_children(0) -> ok;
create_children(N) ->
  Child = spawn_link(?MODULE, child, [0]), % spawn + link
  io:format("Child ~p created~n", [Child]),
  Child ! {add, 0},
  create_children(N-1).

master_loop(Count) ->
  receive
    {value, Child, V} ->
      io:format("child ~p has value ~p ~n", [Child, V]),
      Child ! {add, rand:uniform(10)},
      master_loop(Count);
    {’EXIT’, Child, normal} ->
    io:format("child ~p has ended ~n", [Child]),
    if
      Count =:= 1 -> ok; % this was the last
      true -> master_loop(Count-1)
    end;
  {’EXIT’, Child, _} -> % "unnormal" termination
    NewChild = spawn_link(?MODULE, child, [0]),
    io:format("child ~p has died, now replaced by ~p ~n",
      [Child, NewChild]),
    NewChild ! {add, rand:uniform(10)},
    master_loop(Count)
  end.


child(Data) ->
receive
  {add, V} ->
    NewData = Data+V,
    BadChance = rand:uniform(10) < 2,
    if
      % random error in child:
      BadChance -> error("I’m dying");
      % child ends naturally:
      NewData > 30 -> ok;
      % there is still work to do:
      true -> the_master ! {value, self(), NewData},
        child(NewData)
   end
end.

