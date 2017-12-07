module ZipListApp where

import Control.Applicative
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes


data List a = Nil | Cons a (List a) deriving (Eq, Show)

take' :: Int -> List a -> List a
take' 0 _ = Nil
take' _ Nil = Nil
take' n (Cons a la) = Cons a $ take' (n-1) la


instance Monoid (List a) where
  mempty = Nil
  mappend a Nil = a
  mappend Nil a = a
  mappend (Cons x xs) ys = Cons x $ xs `mappend` ys

instance Functor List where
  fmap f Nil = Nil
  fmap f (Cons a la) = Cons (f a) $ fmap f la

instance Applicative List  where
  pure x = Cons x Nil
  (<*>) _ Nil = Nil
  (<*>) Nil _ = Nil
  (<*>) (Cons x lx) ca = fmap x ca <> (lx <*> ca)

instance Arbitrary a => Arbitrary(List a) where
  arbitrary = Cons <$> arbitrary <*> arbitrary

newtype ZipList' a = ZipList' (List a) deriving (Eq, Show)

instance Arbitrary a => Arbitrary (ZipList' a) where
  arbitrary = ZipList' <$> arbitrary

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = xs' `eq` ys'
    where
      xs' = let (ZipList' l) = xs
            in take' 3000 l
      ys' = let (ZipList' l) = ys
            in take' 3000 l

instance Functor ZipList' where
  fmap f (ZipList' xs) = ZipList' $ fmap f xs

repeatList :: a -> List a
repeatList x = xs
  where
    xs = Cons x xs

zipListWith :: (a -> b -> c) -> List a -> List b -> List c
zipListWith _ Nil _ = Nil
zipListWith _ _ Nil = Nil
zipListWith f (Cons a as) (Cons b bs) = Cons (f a b) $ zipListWith f as bs


instance Applicative ZipList' where
  pure x = ZipList' (repeatList x)
  ZipList'  xs <*> ZipList' ys = ZipList' (zipListWith id xs ys)
