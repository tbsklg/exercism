module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired = null . foldr validate [] . filter (`elem` "[]{}()")
 where
  validate '(' (')' : xs) = xs
  validate '[' (']' : xs) = xs
  validate '{' ('}' : xs) = xs
  validate x xs = x : xs
