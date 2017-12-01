module Law where

import Control.Applicative

mpure :: a -> Maybe a
mpure = pure

-- :t ($) (a -> b) -> a -> b
embed :: Num a => (a -> b) -> b
embed = ($ 2)

mApply :: Maybe ((a -> b) -> b) -> Maybe (a -> b) -> Maybe b
mApply = (<*>)

myTest = if mpure ($ 2) `mApply` Just (+2) == (Just (+2) <*> pure 2)
          then "Yes it works!"
          else "No, something gets wrong."
-- "Yes"
