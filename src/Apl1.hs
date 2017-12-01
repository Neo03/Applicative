module Apl1  where

import Control.Applicative
import Data.Monoid
import Test.QuickCheck
--import Test.QuickCheck.Arbitrary
import Test.QuickCheck.Classes
import Test.QuickCheck.Checkers



instance Monoid a => Monoid (ZipList a) where
  mempty = pure mempty
  mappend = liftA2 mappend

--instance Arbitrary a => Arbitrary (ZipList a) where
  --arbitrary = ZipList <$> arbitrary

--instance Arbitrary a => Arbitrary (Sum a) where
  --arbitrary = Sum <$> arbitrary

instance Eq a => EqProp (ZipList a) where
  (=-=) = eq
--instance Applicative ZipList where
--  pure x = ZipList (repeat x)
  --ZipList fs <*> ZipList xs = ZipList (zipWith id fs xs)
