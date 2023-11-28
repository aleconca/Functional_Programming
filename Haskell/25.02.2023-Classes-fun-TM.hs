{-
We want to define a data structure for the tape of a Turing machine: Tape is a parametric data structure with
respect to the tape content, and must be made of three components:
1. the portion of the tape that is on the left of the head;
2. the symbol on which the head is positioned;
3. the portion of the tape that is on the right of the head.

Also, consider that the machine has a concept of "blank" symbols, so you need to add another component in the
data definition to store the symbol used to represent the blank in the parameter type.
1. Define Tape.
2. Make Tape an instance of Show and Eq, considering that two tapes contain the same values if their stored
values are the same and in the same order, regardless of the position of their heads.
3. Define the two functions left and right, to move the position of the head on the left and on the right.
4. Make Tape an instance of Functor and Applicative.
-}
