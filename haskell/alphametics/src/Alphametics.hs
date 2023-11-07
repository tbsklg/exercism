module Alphametics (solve) where

import Text.Parsec (
  Parsec,
  ParsecT,
  eof,
  letter,
  many1,
  parse,
  sepBy,
  string,
 )

type Result = String
type Words = [String]

data Expression = Expression Words Result deriving (Show, Eq)

solve :: String -> Maybe [(Char, Int)]
solve puzzle = error "You need to implement this function."

parseExpression :: String -> Expression
parseExpression puzzle = case expressionParser "" xs of
  Left err -> error err
  Right expression -> expression
 where
  expressionParser = do
    [left, right] <- sepBy arithemticParser (string " == ")

  arithemticParser = do
