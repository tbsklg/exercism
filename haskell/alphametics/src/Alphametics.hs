module Alphametics (solve) where

import Data.List.Split
import Text.Parsec
import Debug.Trace

data Expr
  = Var [Char] | Plus Expr Expr | Equals Expr Expr | Null
  deriving (Show, Eq)

-- >>> parseExpression "I + I == B"
-- Nothing

solve :: String -> Maybe [(Char, Int)]
solve puzzle = error "You need to implement this function."

parseExpression :: String -> Maybe Expr
parseExpression xs = case parse expressionParser "" xs of
  Left e -> traceShow e Nothing
  Right expression -> Just expression
  where

    -- parse i.e.
    -- "AA == BB" shouldbe Equals (Number "AA") (Number "BB")
    -- "I + BB == ILL" shouldbe Equals (Add (Number "I") (Number "BB")) (Number "ILL")
    -- "A + B + C == D" shouldbe Equals (Add (Add (Number "A") (Number "B")) (Number "C")) (Number "D")
    expressionParser = do
      l <- many1 letter
      spaces <|> eof
      o <- string "+" <|> string "=="
      spaces
      case o of
        "+" -> do
          spaces
          e2 <- expressionParser
          return $ Plus (Var l) e2
        "==" -> do
          r <- many1 letter
          return $ Equals (Var l) (Var r)
        _ -> return Null

