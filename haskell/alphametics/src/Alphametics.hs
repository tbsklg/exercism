module Alphametics (solve) where

import Data.List ( find, delete, nub )
import Data.List.Split (splitOn)
import Data.Maybe ( fromJust )

type Equation = (Operands, Result)

type Operands = [String]

type Result = String

type Combinations = [[Int]]

solve :: String -> Maybe [(Char, Int)]
solve puzzle = case parse puzzle of
  Left _ -> Nothing
  Right equation ->
    find (`testCombination` equation) $
    filter (not . hasLeadingZero equation) $
    possibleCombinations equation

parse :: String -> Either String (Operands, Result)
parse xs = case splitOn " == " xs of
  [[], []] -> Left "No input provided"
  [[], _] -> Left "No operands provided"
  [_, []] -> Left "No result provided"
  [operands, result] -> Right (splitOn " + " operands, result)
  _ -> Left "Invalid input, expected 'operands == result'"

hasLeadingZero :: Equation -> [(Char, Int)] -> Bool
hasLeadingZero (operands, result) state =
  let flhs = map head operands
      frhs = head result
   in any ((== 0) . fromJust . flip lookup state) (flhs ++ [frhs])

possibleCombinations :: Equation -> [[(Char, Int)]]
possibleCombinations (os, r) =
  let a = nub (r ++ concat os)
      c = combinations $ length a
   in map (zip a) c

testCombination :: [(Char, Int)] -> Equation -> Bool
testCombination state (operands, result) =
  let lhs :: Int
      lhs = sum $ map (asInt . map (fromJust . flip lookup state)) operands
      rhs :: Int
      rhs = asInt $ map (fromJust . flip lookup state) result
   in lhs == rhs

asInt :: [Int] -> Int
asInt = read . concatMap show

combinations :: Int -> Combinations
combinations l = go l [0 .. 9] []
  where
    go :: Int -> [Int] -> [Int] -> [[Int]]
    go l xs c
      | l == 0 = [c]
      | otherwise = concatMap (\x -> go (l - 1) (delete x xs) (x : c)) xs
