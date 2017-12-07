module Exers3 where

import Data.Monoid (Monoid, (<>))
--import Data.Semigroup (Semigroup, (<>))
import Control.Applicative
import Test.QuickCheck (Arbitrary, arbitrary, elements)
import Test.QuickCheck.Checkers (quickBatch, eq, (=-=), EqProp)
import Test.QuickCheck.Classes (applicative)

--------------------------- data Pair a = Pair a a ------------------------

data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair  where
  fmap f (Pair a a') = Pair (f a) (f a')

instance  Applicative Pair where
  pure x = Pair x x
  (<*>) (Pair a a') (Pair b b') = Pair (a b) (a' b')

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    return (Pair a a)

instance Eq a => EqProp (Pair a) where (=-=) = eq

-- quickBatch $ applicative (Pair ("b", "w", 1) ("b", "w", 1))

-------------------- data Two a b = Two a b ----------------------------------

data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance (Monoid a) => Applicative (Two a) where
  pure  = Two mempty
  (<*>) (Two a x) (Two b y) = Two (a <> b) (x y)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

instance (Eq a, Eq b) => EqProp (Two a b) where (=-=) = eq

-- quickBatch $ applicative (Two ("b", "w", [1])("b", ["w"], 1))
-- quickBatch $ applicative (undefined :: Two String (Int, Double, Char))

------------ data Three a b c = Three a b c ----------------------------------

data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure = Three mempty mempty
  (<*>) (Three a b c) (Three d e f) = Three (a <> d) (b <> e) (c f)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary(Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where (=-=) = eq

-- quickBatch $ applicative (Three ("b", "w", [1]) ("b", ["w"], [1]) (["b"], "w", 1))

----------------- data Three' a b = Three' a b b ------------------------------

data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b b') = Three' a (f b) (f b')

instance (Monoid a) => Applicative (Three' a) where
  pure x = Three' mempty x x
  (<*>) (Three' a b b') (Three' c d d') = Three' (a <> c) (b d) (b' d')

instance (Arbitrary a, Arbitrary b) => Arbitrary(Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Three' a b b)

instance (Eq a, Eq b) => EqProp (Three' a b) where (=-=) = eq

--------------- data Four a b c d = Four a b c d ------------------------------

data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure = Four mempty mempty mempty
  (<*>) (Four a b c d) (Four e f g h) = Four (a <> e) (b <> f) (c <> g) (d h)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where
  (=-=) = eq

  -- quickBatch $ applicative (Four "b" [1] "c" ("c", "h", 2))
  -- quickBatch $ applicative (undefined :: Four String [Int] String (Int, Double, Char))

------------------------ Four' a b = Four' a a a b ---------------------------------

data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a) where
  fmap f (Four' a b c d) = Four' a b c (f d)

instance Monoid a => Applicative (Four' a)where
  pure  = Four' mempty mempty mempty
  (<*>) (Four' a b c d) (Four' a' b' c' d') = Four' (a <> a') ( b <> b') (c <> c') (d d')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Four' a a a b)

instance (Eq a, Eq b) => EqProp (Four' a b) where (=-=) = eq

-- quickBatch $ applicative (Four' [2] [1] [1] ("c", "h", 2))
-- quickBatch $ applicative (undefined :: Four' String (Int, Double, Char))
