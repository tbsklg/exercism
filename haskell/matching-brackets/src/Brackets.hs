module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired raw = validate (synth raw) []
 where
  validate :: String -> String -> Bool
  validate [] [] = True
  validate (x : xs) []
    | isOpen x = validate xs [closing x]
    | otherwise = False
  validate (x : xs) s@(y : ys)
    | isOpen x = validate xs (closing x : s)
    | otherwise = x == y && validate xs ys
  validate _ _ = False

  isOpen :: Char -> Bool
  isOpen x = x `elem` "({["

  closing :: Char -> Char
  closing '[' = ']'
  closing '{' = '}'
  closing '(' = ')'
  closing x = x

  synth :: String -> String
  synth = filter (`elem` "[](){}")
