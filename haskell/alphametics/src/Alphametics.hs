module Alphametics (solve) where

import Data.List.Split (splitOn)

type State = [(String, Int)]
type Result = String

data Ast = Literal String | Binary Ast Operator Ast deriving (Show, Eq)
data Operator = Plus deriving (Show, Eq)

solve :: String -> Maybe [(Char, Int)]
solve puzzle = error "You need to implement this function."

-- parse a string to and ast and a result
-- "a + b + c" =
parse :: String -> (Ast, Result)
parse xs = undefined

