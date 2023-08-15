module BinarySearch (find) where

import Data.Array

find :: (Ord a, Show a) => Array Int a -> a -> Maybe Int
find array x
  | null array = Nothing
  | otherwise = find' (minimum . indices $ array, maximum . indices $ array)
  where
    find' (l, h)
      | l > h = Nothing
      | x == middleElem = Just middleIndex
      | x < middleElem = find' (l, h - 1)
      | otherwise = find' (l + 1, h)
      where
        middleIndex = (h + l) `div` 2
        middleElem = array ! middleIndex
