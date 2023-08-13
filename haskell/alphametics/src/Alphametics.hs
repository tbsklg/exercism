module Alphametics (solve) where

import Data.Char (isSpace)
import Data.Function (on)
import Data.List (nub, nubBy)
import Data.Maybe (fromMaybe, mapMaybe)
import Safe (lastMay)
import Text.Parsec (char, letter, many1, parse, string)
import Text.Parsec.Combinator (sepBy)
import Debug.Trace

type Words = [String]

type Result = String

type State = [(Char, Int)]

data Expression = Expression Words Result deriving (Show, Eq)

solve :: String -> [Maybe State]
solve puzzle = search ([], 0) (asExpression puzzle)

search :: (State, Int) -> Expression -> [Maybe State]
search (state, _) (Expression [] []) = [Just state]
search (state, carry) expr =
  concatMap
    (\s -> search s (remaining expr))
    . filter (\s -> isValidSubExpression s (chunk expr))
    . candidates (state, carry)
    $ chunk expr

remaining :: Expression -> Expression
remaining (Expression [] []) = Expression [] []
remaining (Expression [] r) = Expression [] (init r)
remaining (Expression w r) = Expression left (init r)
  where
    left = filter (not . null) . map init $ w

chunk :: Expression -> Expression
chunk (Expression [] []) = Expression [] []
chunk (Expression [] r) = Expression [] [last r]
chunk (Expression w r) = Expression chunkedWords chunkedResult
  where
    chunkedWords = map (: []) . mapMaybe lastMay $ w
    chunkedResult = case lastMay r of
      Nothing -> []
      Just x -> [x]

isValidSubExpression :: (State, Int) -> Expression -> Bool
isValidSubExpression ([], _) _ = False
isValidSubExpression (state, _) (Expression w r) = traceShow (state, w, r, left `mod` 10 == right) left `mod` 10 == right
  where
    left = sum . map (asInt . map (`lookup` state)) $ w
    right = asInt $ map (`lookup` state) r

asInt :: [Maybe Int] -> Int
asInt = foldl (\acc x -> acc * 10 + fromMaybe 0 x) 0

candidates :: (State, Int) -> Expression -> [(State, Int)]
candidates (state, carry) (Expression w r) = map candidate . allCombinations missingDigits $ letters
  where
    missingDigits = filter (`notElem` map snd state) [0 .. 9]
    keys = map fst state
    letters = filter (`notElem` keys) . nub . concat $ w ++ [r]

    candidate s = (s ++ state, newCarry)
      where
        left = map (asInt . map (`lookup` (s ++ state))) w
        newCarry = (sum left + carry) `div` 10

asExpression :: String -> Expression
asExpression xs = case parse expressionParser "" (filter (not . isSpace) xs) of
  Left err -> error (show err)
  Right (w, r) -> Expression w r
  where
    expressionParser = do
      w <- sepBy wordParser (char '+')
      _ <- string "=="
      result <- many1 letter
      return (w, result)

    wordParser = many1 letter

allCombinations :: [Int] -> [Char] -> [[(Char, Int)]]
allCombinations [] _ = [[]]
allCombinations _ [] = [[]]
allCombinations _ (x : xs) =
  filter
    (\ls -> length ls == (length . nubBy ((==) `on` snd) $ ls))
    [(x, y) : zs | y <- [0 .. 9], zs <- allCombinations [0 .. 9] xs]
