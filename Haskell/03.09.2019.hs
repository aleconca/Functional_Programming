{-Consider the data structure Tril, which is a generic container consisting of three lists.
1) Give a data definition for Tril.
2) Define list2tril, a function which takes a list and 2 values x and y, say x < y, and builds a Tril, where
the last component is the ending sublist of length x, and the middle component is the middle sublist of
length y-x. Also, list2tril L x y = list2tril L y x.
E.g. list2tril [1,2,3,4,5,6] 1 3 should be a Tril with first component [1,2,3], second component [4,5], and
third component [6].
3) Make Tril an instance of Functor and Foldable.
4) Make Tril an instance of Applicative, knowing that the concatenation of 2 Trils has first component
which is the concatenation of the first two components of the first Tril, while the second component is the
concatenation of the ending component of the first Tril and the beginning one of the second Tril (the third
component should be clear at this point).-}
