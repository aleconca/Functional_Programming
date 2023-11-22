{-
Define a partitioned list data structure, called Part, storing three elements:
1. a pivot value,
2. a list of elements that are all less than or equal to the pivot, and
3. a list of all the other elements.

Implement the following utility functions, writing their types:
• checkpart, which takes a Part and returns true if it is valid, false otherwise;
• part2list, which takes a Part and returns a list of all the elements in it;
• list2part, which takes a pivot value and a list, and returns a Part;

Make Part an instance of Foldable and Functor, if possible. If not, explain why.
-}
