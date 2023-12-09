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
>BIFs:
>Function Syntax and Evaluation:
>Guarded Functions:

>Apply

>Lambdas

>hof

>Concurrency







