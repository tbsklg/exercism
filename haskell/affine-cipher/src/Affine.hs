module Affine (decode, encode) where

import Data.Char (chr, isLower, isNumber)
import Data.List (elemIndex)
import Data.List.Split (chunksOf)

-- >>> encode (5, 7) "hello 123"
-- Just "qbkkz 123"
-- Just "qbkkz 123"
-- Just "xbt"
decode :: (Int, Int) -> String -> Maybe String
decode key cipherText = error "You need to implement this function."

encode :: (Int, Int) -> String -> Maybe String
encode key plainText = do
  (a, b) <- coprime key
  encrypted <- mapM (encrypt (a, b)) . filter (/= ' ') $ plainText
  return (unwords $ chunksOf 5 encrypted)

encrypt :: (Int, Int) -> Char -> Maybe Char
encrypt (a, b) c =
  if isNumber c
    then Just c
    else do
      i <- alphabetIndex c
      fromAlphabetIndex $ (a * i + b) `mod` 26

fromAlphabetIndex :: Int -> Maybe Char
fromAlphabetIndex i
  | i >= 0 && i < 26 = Just $ chr (i + 97)
  | otherwise = Nothing

alphabetIndex :: Char -> Maybe Int
alphabetIndex c
  | isLower c = elemIndex c ['a' .. 'z']
  | otherwise = elemIndex c ['A' .. 'Z']

coprime :: (Int, Int) -> Maybe (Int, Int)
coprime (a, b)
  | gcd a 26 == 1 = Just (a, b)
  | otherwise = Nothing
