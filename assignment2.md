---
title: Assignment 2 -- Monads and other structures
layout: default
---

# Assignment 2

The GitHub Classrooms link for this assignment is [here](https://classroom.github.com/a/4FyhBxrY).

## Functors, applicative and monad

Given the standard type classes for functors, applicative functors and
monads:

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b

class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  
class Applicative f => Monad f where
  return :: a -> f a
  (>>=) :: f a -> (a -> f b) -> f b
```

Give instances for all three classes for the following data types:

```haskell

data Tree a = Leaf a | Node (Tree a) (Tree a)

data RoseTree a = RoseNode a [RoseTree a] | RoseLeaf

data Teletype a = 
  Get (Char -> Teletype a)
  | Put Char (Teletype a)
  | Return a
```

## Foldable & traversable

Also give instances for the `Foldable` and `Traversible` classes:

```haskell
class Foldable t where
  foldMap :: Monoid m => (a -> m) -> t a -> m 
  
class Traversable t where
  traverse :: Applicative f => (a -> f b) -> t a -> f (t b) 
```

## Maps and keys

Using methods from the above type classes exclusively, show how to
define the following function:

```haskell
lookupAll :: Ord k => [k] -> Data.Map k v -> Maybe [v]
```

This should return `Just vs` if all the argument keys occur in the
map, and `Nothing` otherwise.

Also define the following variant:

```haskell
lookupSome :: Ord k => [k] -> Data.Map k v -> [v]
```

that returns the list of values for which a key exists. You may want
to use functions from `Data.Maybe` to complete this definition.

## Filter

Use `foldMap` to define a generic filter function:

```haskell
gfilter :: Foldable f => (a -> Bool) -> f a -> [a]
```
