module Series (Error (..), largestProduct) where

import Data.Char (digitToInt, isNumber)
import Data.List.Split (divvy)

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

largestProduct :: Int -> String -> Either Error Integer
largestProduct size digits
  | size < 0 || size > length digits = Left InvalidSpan
  | not $ all isNumber digits = Left $ InvalidDigit firstInvalidChar
  | otherwise = Right . maximum . map product' . divvy size 1 $ digits
 where
  product' = toInteger . product . map digitToInt
  firstInvalidChar = head . filter (not . isNumber) $ digits
