module Yacht (yacht, Category (..)) where

import Data.List (group, sort)
import Safe (headMay)

data Category
  = Ones
  | Twos
  | Threes
  | Fours
  | Fives
  | Sixes
  | FullHouse
  | FourOfAKind
  | LittleStraight
  | BigStraight
  | Choice
  | Yacht

yacht :: Category -> [Int] -> Int
yacht Yacht l@(x : _)
  | all (== x) l = 50
  | otherwise = 0
yacht Ones xs = length . filter (== 1) $ xs
yacht Twos xs = sum . filter (== 2) $ xs
yacht Threes xs = sum . filter (== 3) $ xs
yacht Fours xs = sum . filter (== 4) $ xs
yacht Fives xs = sum . filter (== 5) $ xs
yacht Sixes xs = sum . filter (== 6) $ xs
yacht FullHouse xs
  | isFullHouse = sum xs
  | otherwise = 0
  where
    isFullHouse = (== [2, 3]) . sort . map length . group . sort $ xs
yacht FourOfAKind xs = case headMay . filter (\x -> length x >= 4) . group . sort $ xs of
  Just x -> sum . take 4 $ x
  Nothing -> 0
yacht LittleStraight xs
  | sort xs == [1 .. 5] = 30
  | otherwise = 0
yacht BigStraight xs
  | sort xs == [2 .. 6] = 30
  | otherwise = 0
yacht Choice xs = sum xs
yacht _ _ = 0
