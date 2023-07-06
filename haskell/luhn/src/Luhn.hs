module Luhn (isValid) where

import Data.Char (digitToInt)

isValid :: String -> Bool
isValid = validate . concat . words
  where
    validate "0" = False
    validate "1" = False
    validate n = (== 0) . (`mod` 10) . sum . doubleDigit . map digitToInt $ n

    doubleDigit n
      | even $ length n = map normalize . zipWith (*) n . cycle $ [2, 1]
      | otherwise = map normalize . zipWith (*) n . cycle $ [1, 2]

    normalize x
      | x > 9 = abs $ x - 9
      | otherwise = x