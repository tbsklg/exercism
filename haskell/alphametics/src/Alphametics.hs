module Alphametics (solve) where

import Data.List
import Data.List.Split (splitOn)

type Operands = [String]
type Result = String
type Evaluation = (Combinations, Result)
type Combinations = [[Int]]
type Combination = [Int]
type Carry = Int

solve :: String -> Maybe [(Char, Int)]
solve puzzle = Nothing

parse :: String -> Either String (Operands, Result)
parse xs = case splitOn " == " xs of
  [[], []] -> Left "No input provided"
  [[], _] -> Left "No operands provided"
  [_, []] -> Left "No result provided"
  [operands, result] -> Right (splitOn " + " operands, result)
  _ -> Left "Invalid input, expected 'operands == result'"

testCombinations :: (Combinations, Carry) -> Combinations
testCombinations c = undefined

evalCombination :: Combination -> Bool
evalCombination [] = False
evalCombination [x] = True
evalCombination xs = (==) ((sum . init $ xs) `mod` 10) (last xs)

combinations :: Int -> Combinations
combinations l = go l [0 .. 9] []
  where
    go :: Int -> [Int] -> [Int] -> [[Int]]
    go l xs c
      | l == 0 = [c]
      | otherwise = concatMap (\x -> go (l - 1) (delete x xs) (x : c)) xs

