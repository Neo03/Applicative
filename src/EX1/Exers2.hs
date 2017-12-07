module Exers2 where

import Data.Monoid (Monoid)
import Data.Semigroup (Semigroup, (<>))
import Control.Applicative
import Test.QuickCheck (Arbitrary, arbitrary, elements)
import Test.QuickCheck.Checkers (quickBatch, eq, (=-=), EqProp)
import Test.QuickCheck.Classes (applicative)

data Pair a = Pair a a deriving (Show)

newtype Identity a = Identity a deriving (Eq,Show)

instance (Semigroup a) => Semigroup (Identity a)where
  Identity a <> Identity b = Identity (a <> b)

instance (Semigroup a, Monoid a) => Monoid (Identity a) where
  mempty = Identity mempty
  mappend = (<>)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity  where
  pure  =  Identity
  (<*>) (Identity a)(Identity b) = Identity (a b)
  --(<*>) (Identity f) x = fmap f x   -- second variant

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

instance Eq a => EqProp (Identity a) where (=-=) = eq
