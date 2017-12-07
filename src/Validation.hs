module Validation where

import Control.Applicative
import Data.Monoid (Monoid, (<>))
import Test.QuickCheck (Arbitrary, arbitrary, elements)
import Test.QuickCheck.Checkers (quickBatch, eq, (=-=), EqProp)
import Test.QuickCheck.Classes (applicative)

data Validation err a = Failure err
                        | Success a
                        deriving (Eq, Show)

data Sum a b = First a
              | Second b
              deriving (Eq, Show)

instance Functor (Sum a) where
  fmap f (First a)  = First a
  fmap f (Second b) = Second (f b)

instance Applicative (Sum a) where
  pure = Second
  _ <*> First a = First a
  First a <*> _ = First a
  (Second a) <*> (Second b) = Second (a b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Sum a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [First a, Second b]

instance Functor (Validation err) where
  fmap f (Failure err) = Failure err
  fmap f (Success a) = Success (f a)

instance (Monoid err) => Applicative (Validation err) where
  pure = Success
  Failure e <*> Failure e1 = Failure (e <> e1)
  Success a <*> Failure err = Failure err
  Failure err <*> Success a = Failure err
  Success a <*> Success a1 = Success (a a1)

instance (Arbitrary err, Arbitrary a) => Arbitrary (Validation err a) where
  arbitrary = do
    err <- arbitrary
    a <- arbitrary
    elements[Failure err, Success a]

instance (Eq a, Eq b) => EqProp (Sum a b) where (=-=) = eq

instance (Eq err, Eq a) => EqProp (Validation err a) where (=-=) = eq
