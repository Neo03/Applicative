module List where

import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data List a =
  Nil
  | Cons a (List a) deriving (Eq,Show)

append :: List a -> List a -> List a
append _ Nil = Nil
append (Cons x xs) ys = Cons x $ xs `append` ys

fold :: (a -> b -> b) -> b -> List a -> b
fold _ b Nil = b
fold f b (Cons a la) = f a $ fold f b la

concat' :: List (List a) -> List a
concat' = fold append Nil

---------- ? Answer always only Nil ? -----------------------------
flatMap :: (a -> List b) -> List a -> List b
flatMap _ Nil = Nil
--flatMap f (Cons a la) =  concat' $ fmap f (Cons a la)
faltMap f (Cons a la) = concat' $ Cons (f a) (fmap f la)
--faltMap f (Cons a la) = concat' $ Cons (f a) (fmap f la)

-------- ? Answer always only Nil ? -------------------------------

instance Monoid (List a) where
  mempty = Nil
  mappend a Nil = a
  mappend Nil a = a
  mappend (Cons x xs) ys = Cons x $ xs `mappend` ys

instance Arbitrary a => Arbitrary (List a) where
  arbitrary = do
    x <- arbitrary
    y <- arbitrary
    return (Cons x(Cons y Nil))

instance Functor List where
  fmap _ Nil  = Nil
  fmap f (Cons x la) = Cons (f x) (fmap f la)

instance Applicative List where
  pure x = Cons x Nil
  Nil <*> _ = Nil
  _ <*> Nil = Nil
  (<*>) (Cons f b) ca = fmap f ca <> (b <*> ca)

instance Eq a => EqProp (List a) where (=-=) = eq
