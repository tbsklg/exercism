module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.List ((\\))

anagramsFor :: String -> [String] -> [String]
anagramsFor w = filter (isAnagramOf w)
  where
    y `isAnagramOf` x =
      length y == length x
        && lowercase y /= lowercase x
        && null (lowercase y \\ lowercase x)
    
    lowercase = map toLower
