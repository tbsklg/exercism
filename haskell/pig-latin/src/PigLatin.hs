module PigLatin (translate) where

import Data.List (isPrefixOf)

translate :: String -> String
translate = unwords . map translate' . words
  where
    translate' w
      | startsWithAny ["a", "e", "i", "o", "u"] = w ++ "ay"
      | startsWithAny ["yt" , "xr"] = w ++ "ay"
      | startsWithAny ["squ", "thr", "sch"] = drop 3 w ++ take 3 w ++ "ay"
      | startsWithAny ["ch", "qu", "th", "rh"] = drop 2 w ++ take 2 w ++ "ay"
      | otherwise = drop 1 w ++ take 1 w ++ "ay"
      where
        startsWithAny :: [String] -> Bool
        startsWithAny = any (`isPrefixOf` w)
