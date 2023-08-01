module RunLength (decode, encode) where

import Data.Char (isDigit)
import Data.List (group)

decode :: String -> String
decode [] = []
decode encodedText = replicate numberOfChars charToRepeat ++ decode nextToDecode
  where
    numberOfChars :: Int
    numberOfChars
      | null digits = 1
      | otherwise = read digits
      where
        digits = takeWhile isDigit encodedText

    charToRepeat :: Char
    (charToRepeat : nextToDecode) = dropWhile isDigit encodedText

encode :: String -> String
encode = concatMap encode' . group
  where
    encode' :: String -> String
    encode' [] = []
    encode' [x] = [x]
    encode' l@(x : _) = (show . length $ l) ++ [x]
