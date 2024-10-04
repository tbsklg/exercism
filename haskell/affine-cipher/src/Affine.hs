module Affine (decode, encode) where

import Data.Char (chr, isAlphaNum, isLower, isNumber)
import Data.List (elemIndex)
import Data.List.Split (chunksOf)

decode :: (Int, Int) -> String -> Maybe String
decode key cipherText = do
  key' <- coprime key
  mapM (decrypt key') . filter isAlphaNum $ cipherText

encode :: (Int, Int) -> String -> Maybe String
encode key plainText = do
  key' <- coprime key
  encrypted <- mapM (encrypt key') . filter isAlphaNum $ plainText
  return (unwords $ chunksOf 5 encrypted)

decrypt :: (Int, Int) -> Char -> Maybe Char
decrypt (a, b) c =
  if isNumber c
    then Just c
    else do
      i <- alphabetIndex c
      fromAlphabetIndex $ (inverse 26 a * (i - b)) `mod` 26

inverse :: Int -> Int -> Int
inverse m a = until (\x -> a * x `mod` m == 1) (+ 1) 1

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
