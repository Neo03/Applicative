module Ex1 where

import Control.Applicative
import Data.List (elemIndex)

f x = lookup x [(3, "hello"), (4, "julie"), (5, "kbai")]
g y = lookup y [(7, "sup?"), (8, "chris"), (9, "aloha")]

h z = lookup z [(2, 3), (4, 5), (6, 7)]
m x = lookup x [(4, 10), (8, 13), (1, 9001)]

---------------- Number 1 -----------------------------------------------
added :: Maybe Integer
added = (+3) <$> lookup 3 (zip [1,2,3] [4,5,6])

----------------  Number 2 ----------------------------------------------
y :: Maybe Integer
y = (+3) <$> lookup 3 (zip [1,2,3] [4,5,6])

z :: Maybe Integer
z = (+3) <$> lookup 2 (zip [1,2,3] [4,5,6])

tupled :: (Maybe Integer, Maybe Integer)
tupled = (,) y z
 ------------- Number 3 -----------------------------------------------

x1 :: Maybe Int
x1 = elemIndex 3 [1,2,3,4,5]

y1 :: Maybe Int
y1 = elemIndex 4 [1,2,3,4,5]

max' :: Maybe Int -> Maybe Int -> Maybe Int
max' = max

maxed :: Maybe Int
maxed = max' x1 y1

----------------- Number 4 ---------------------------------------------

xs = [1,2,3]
ys = [4,5,6]

x2 :: Maybe Integer
x2 = lookup 3 $ zip xs ys

y2 :: Maybe Integer
y2 = lookup 2 $ zip xs ys

summed :: (Maybe Integer, Integer)
summed = sum <$> (,) x2 y2
