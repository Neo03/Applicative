module Exers1 where

import Data.Monoid (Monoid, (<>))
import Control.Applicative
import Test.QuickCheck (Arbitrary, arbitrary, elements)
import Test.QuickCheck.Checkers (quickBatch, eq, (=-=), EqProp)
import Test.QuickCheck.Classes (applicative)


--type (,)
x1 = (pure :: Monoid b => a -> ((,)b)a) 4 :: (String, Int)

x2 = ((<*>) :: Monoid c => (,) c (a -> b) -> (,) c a -> (,) c b) ("asd", (+2)) ("zxc", 2)

-- type (->)e
x3 = pure :: a -> ((->)e) a
x4 = (<*>) :: ((->)e)(a -> b) -> ((->)e) a -> ((->)e) b
