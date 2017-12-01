module Ex2  where

import Control.Applicative

------------------ Identity a ------------------------------------------
newtype Identity a = Identity a deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity  where
  pure               = Identity
  (Identity f) <*> (Identity a) = Identity (f a)

------------- Const a --------------------------------------------------
newtype Constant a b = Constant {getConstant :: a} deriving (Eq,Ord, Show)

instance Functor (Constant a) where
  fmap f (Constant a) = Constant a

instance Monoid a => Applicative (Constant a) where
  pure x = Constant (mempty x)
  --_ <*> Constant x = Constant x -- тоже правильно
  Constant x <*> _ = Constant x
