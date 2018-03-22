---
title: Assignment 4 -- Transformers and generics
layout: default
---

# Assignment 4 -- Transformers and generics

[The GitHub Classrooms link for this assignment is here](https://classroom.github.com/a/XAaH3jMH).

## Parsing with error messages

Instead of the *backtracking* parsers covered in the lectures and
*Talen & Compilers*, we can also define the following parser type:

```
newtype ErrorMsg = ErrorMsg String

newtype Parser a = Parser (String -> Either ErrorMsg (a,String))
```

A parser consists of a function that reads from a `String` to produce
either an error message or a result of type `a` and the remaining
`String` that has not been parsed. This parser type does not allow
*backtracking* and is less expressive than the list-based parsers.

### Exercise 1 -- Functor, monad and applicative (10%)

Write the `Functor`, `Applicative`, `Monad`, and `Alternative` instances
for the parser type above.

### Exercise 2 -- Monad transformers (10%)

Describe the `Parser` type as a series of monad transformers. 

### Exercise 3 -- Generic parsing (80%)

Haskell's `Show` and `Read` classes provide an easy way to display and
parse user-defined data structures.

Use GHC Generics and the `Parser` type defined in Exercise 2, together
with any auxiliary combinators that you need, to define a *generic*
`Parse` class. You may want to have a look at `Generic.Deriving.Show`
to see how a generic `Show` instance can be derived. You may want to
have a look at the `uuparsinglib`, `attoparsec` or `parsec` libraries
for some inspiration on useful auxiliary functions that you may want
to define.


Writing a generic read for all possible constructs is not feasible,
but try to cover as much of the language as you can. What cases cannot
be handled without backtracking?

#### Grading

Out of the 8 points assigned to this exercise:

* An implementation which holds "basic" ADTs should get a 6.
    To make it more precise, this means that it works for:

    ```haskell
    data Bool    = True | False
    data IntTree = Leaf Int | Node IntTree IntTree
    ```

* If fixity of operators is taken into account, add 1 extra point.
    To make it more precise, that means that the parser can handle
    `Leaf 1 :|: (Leaf 2 :|: Leaf 3)` when `IntTree` is declared as:

    ```haskell
    data IntTree = Leaf Int | IntTree :|: IntTree
    ```

* If record labels are taken into account, add 1 extra point.
    To make it more precise, that means that the parser can handle
    `Number { n = 1 }`  for a data type declared as:

    ```haskell
    data Number = Number { n :: Int }
    ```