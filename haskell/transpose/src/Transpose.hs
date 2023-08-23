module Transpose (transpose) where

import Safe (headMay, tailMay)
import Data.Maybe (fromMaybe)

transpose :: [String] -> [String]
transpose [] = []
transpose lines = go . pad $ lines
  where
    go :: [String] -> [String]
    go ls
      | all null ls = []
      | otherwise = concatMap line ls : go (map remaining ls)

    line :: String -> String
    line l = case headMay l of
      Nothing -> []
      Just x -> [x]

    remaining :: String -> String
    remaining l = fromMaybe [] (tailMay l)

    pad :: [String] -> [String]
    pad [] = []
    pad [x] = [x]
    pad (x:y:xs)
      | length x > length y = x : pad (y:xs)
      | otherwise = (x ++ replicate (nextMaximum - length x) ' ') : pad (y:xs)
      where
        nextMaximum = maximum . map length $ (y:xs)
