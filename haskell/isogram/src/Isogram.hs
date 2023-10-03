module Isogram (isIsogram) where

import Data.Char (toLower, isAlpha)
import Data.List (nub)

isIsogram :: String -> Bool
isIsogram = allUnique . letters

allUnique xs = nub xs == xs 

letters = map toLower . filter isAlpha

