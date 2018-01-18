---
title: Assignment 1 -- Smooth Permutations
layout: default
---

# Assignment 1 -- Smooth Permutations

In this assignment we want to build a library to generate smooth permutations. Given a list of integers `xs` and an integer `d`, a _smooth permutation of `xs` with maximum distance `d`_ is a permutation in which the difference of any two consecutive elements is at most `d`.

A naïve implementation just generates all the permutations of a list,

```haskell
split []     = []
split (x:xs) = (x, xs) : [(y, x:ys) | (y, ys) <- split xs]

perms []     = [[]]
perms xs     = [(v:p) | (v, vs) <- split xs, p <- perms vs]
```

and then filters out those which are smooth,

```haskell
smooth n (x:y:ys) = abs (y - x) < n && smooth n (y:ys)
smooth _ _        = True

smoothPerms :: Int -> [Int] -> [[Int]]
smoothPerms n xs = filter (smooth n) (perms xs)
```

### Exercise 1 -- Packaging and documentation (10%)

1. Create a library `smoothies` which exports `perms` and `smoothPerms` (feel free to choose the name of the module). You should be able to install the package by just running `cabal install` in it.
2. Document the exported functions using [Haddock](http://haskell-haddock.readthedocs.io/en/latest/index.html).

### Exercise 2 -- Testsuite (10%)

1. Write a comprehensive set of properties to check that `smoothPerms` works correctly.
2. Integrate your testsuite with Cabal using `tasty` ([here is how you do so](https://github.com/feuerbach/tasty#project-organization-and-integration-with-cabal)).

### Exercise 3 -- Implementation with trees (30%)

The initial implementation of `smoothPerms` is very expensive. A better approach is to build a tree, for which it holds that each path from the root to a leaf corresponds to one of the possible permutations, next prune this tree such that only smooth paths are represented, and finally use this tree to generate all the smooth permutations from.

1. Define a data type `PermTree` to represented a permutation tree.
2. Define a function `listToPermTree` which maps a list onto this tree.
3. Define a function `permTreeToPerms` which generates all permutations represented by a tree.

    At this point the `perms` functions given above should be the composition of `listToPermTree` and `permTreeToPerms`.

4. Define a function `pruneSmooth`, which leaves only smooth permutations in the tree.
5. Redefine the function `smoothPerms`.

This new implementation should be available in a new module of your package, and pass all the tests you developed in exercise 2.

### Exercise 4 -- Unfolds (30%)

Recall the definition of `unfoldr` for lists,

```haskell
unfoldr :: (s -> Maybe (a, s)) -> s -> [a]
unfoldr next x = case next x of
                   Nothing     -> []
                   Just (y, r) -> y : unfoldr next r
```

We can define an unfold function for binary trees as well:

```haskell
data Tree a = Leaf a | Node (Tree a) (Tree a)
            deriving Show

unfoldTree :: (s -> Either a (s, s)) -> s -> Tree a
unfoldTree next x = case next x of
                      Left  y      -> Leaf y
                      Right (l, r) -> Node (unfoldTree next l) (unfoldTree next r)
```

Define the following functions in a new module which should be exposed as part of your library. Define the functions using `unfoldr` or `unfoldTree`, as required.

1. `iterate :: (a -> a) -> a -> [a]`. The call `iterate f x` generates the infinite list `[x, f x, f (f x), ...]`.
2. `map :: (a -> b) -> [a] -> [b]`.
3. `balanced :: Int -> Tree ()`, which generates a balanced binary tree of the given height.
4. `sized :: Int -> Tree Int`, which generates any tree with the given number of nodes. Each leaf in the returned tree should have a unique label.

Define an `unfoldPermTree` function which generates a `PermTree` as defined in the previous exercise. Use that `unfoldPermTree` to implement a new version of `listToPermTree`.

### Exercise 5 -- Proofs (20%)

1. Prove using induction and equational reasoning that `length (split xs) = length xs` and that `length (snd (split xs)) = length xs - 1`.
2. Prove that if `p` is a smooth permutation with maximum distance `d` and head element `h`, then `sum p <= (length p) * (h + d)`.
3. (Extra) Prove that `length (perms xs) = factorial (length xs)`. Use the following identity as a lemma.

$$\mathsf{length} \, [t \, | \, x \leftarrow g, y \leftarrow h \, x]
= \sum_{x \, \in \, g} \mathsf{length} \, (h \, x)$$