module Alphametics (solve) where

import Control.Monad (msum)
import Data.Char (isSpace)
import Data.Function (on)
import Data.List (nub, nubBy)
import Data.Maybe (fromMaybe)
import Debug.Trace (traceShow)
import Text.Parsec (char, letter, many1, parse, string)
import Text.Parsec.Combinator (sepBy)

type Words = [String]

type Result = String

type State = [(Char, Int)]

type Carry = Int

data Expression = Expression Words Result deriving (Show, Eq)

solve :: String -> [Maybe [(Char, Int)]]
solve puzzle = search ([], 0) (asExpression puzzle)

search :: (State, Int) -> Expression -> [Maybe State]
search (state, carry) expr@(Expression words result)
  | isValid (state, carry) expr = traceShow (words, result) [Just state]
  | otherwise = concatMap (`search` furtherExpression) $ possibilities
  where
    furtherExpression = Expression (filter (not . null) . map init $ words) (if null result then [] else init result)
    subExpression = Expression (map (\x -> [last x]) words) [last result]
    possibilities = candidates (state, carry) subExpression

mergeState :: (State, Int) -> (State, Int) -> (State, Int)
mergeState a ([], _) = a
mergeState (a, c) (b : bs, c') = case lookup (fst b) a of
  Nothing -> mergeState (b : a, c') (bs, c')
  Just _ -> mergeState (a, c') (bs, c')

isValid :: (State, Int) -> Expression -> Bool
isValid ([], _) _ = False
isValid (state, carry) (Expression [] []) = True
isValid (state, carry) (Expression words result) = left == right
  where
    left = (+) carry . sum . map (asInt . map (`lookup` state)) $ words
    right = asInt $ map (`lookup` state) result

asInt :: [Maybe Int] -> Int
asInt = foldl (\acc x -> acc * 10 + fromMaybe 0 x) 0

candidates :: (State, Int) -> Expression -> [(State, Int)]
candidates (state, carry) expr@(Expression words result) =  map candidate . filter isRelevant . allCombinations missingDigits $ letters
  where
    missingDigits = filter (`notElem` map snd state) [0 .. 9]
    keys = map fst state
    letters = filter (`notElem` keys) . nub . concat $ words ++ [result]
    isRelevant s
      | null s = False
      | otherwise = sum left `mod` 10 == right
      where
        left = map (asInt . map (`lookup` (s ++ state))) words
        right = asInt $ map (`lookup` (s ++ state)) result

    candidate s = (s ++ state, newCarry)
      where
        left = map (asInt . map (`lookup` (s ++ state))) words
        right = asInt $ map (`lookup` (s ++ state)) result
        totalSum = sum left + carry
        (newCarry, value) = totalSum `divMod` 10

asExpression :: String -> Expression
asExpression xs = case parse expressionParser "" (filter (not . isSpace) xs) of
  Left err -> error (show err)
  Right (words, result) -> Expression words result
  where
    expressionParser = do
      words <- sepBy wordParser (char '+')
      _ <- string "=="
      result <- many1 letter
      return (words, result)

    wordParser = many1 letter

allCombinations :: [Int] -> [Char] -> [[(Char, Int)]]
allCombinations [] _ = [[]]
allCombinations _ [] = [[]]
allCombinations ds (x : xs) =
  filter
    (\ls -> length ls == (length . nubBy ((==) `on` snd) $ ls))
    [(x, y) : zs | y <- ds, zs <- allCombinations ds xs]
