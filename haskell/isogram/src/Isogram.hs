module Isogram (isIsogram) where

import Data.Char (toLower, isAlpha)
import Data.List (nub)

isIsogram :: String -> Bool
isIsogram xs = (nub . words' $ xs) == words' xs
  where
    words' = filter isAlpha . map toLower
