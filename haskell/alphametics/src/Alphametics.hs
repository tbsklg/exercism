module Alphametics (solve) where

import Data.List.Split
import Text.Parsec
import Debug.Trace

data Expr
  = Number [Char] | Add Expr Expr | Equals Expr Expr | Null
  deriving (Show, Eq)

-- >>> parseExpression "I + I == B"
-- Nothing

solve :: String -> Maybe [(Char, Int)]
solve puzzle = error "You need to implement this function."

-- A + A == B
-- A + A + A == BB
-- C == FF
parseExpression :: String -> Maybe Expr
parseExpression = either (const Nothing) Just . parse expr ""
  where
    expr = do
      left <- many1 letter
      spaces
      char '+'
      spaces
      right <- many1 letter
      spaces
      char '='
      spaces
      result <- many1 letter
      return $ Equals (Add (Number left) (Number right)) (Number result)
