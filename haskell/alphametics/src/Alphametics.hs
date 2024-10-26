module Alphametics (solve) where

import Data.List.Split

data Ast = Literal String | Binary Ast Operator Ast deriving (Show, Eq)
data Operator = Plus deriving (Show, Eq)

solve :: String -> Maybe [(Char, Int)]
solve puzzle = error "You need to implement this function."

parseAst :: String -> Maybe Ast
parseAst xs = 
  let
    [l, r] = splitOn " == " xs
    operands = splitOn " + " l
  in
    Just $ foldr ((\acc c -> Binary acc Plus c) . Literal) (Literal r) operands


