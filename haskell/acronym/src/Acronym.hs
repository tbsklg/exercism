module Acronym (abbreviate) where

import Data.Char (isUpper, toUpper)
import Data.List.Split (splitOneOf)

abbreviate :: String -> String
abbreviate = concatMap (map toUpper . extractCharsToAbbreviate) . splitOneOf " -_"
  where
    extractCharsToAbbreviate [] = []
    extractCharsToAbbreviate (x : xs)
      | length xs < 3 = [x]
      | otherwise = x : filter isUpper xs
