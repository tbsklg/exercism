module Bob (responseFor) where

import Data.Char (isAlpha, isSpace, isUpper)
import Data.List (isSuffixOf)

responseFor :: String -> String
responseFor xs
  | silence = "Fine. Be that way!"
  | yellingAQuestion = "Calm down, I know what I'm doing!"
  | question = "Sure."
  | shouting = "Whoa, chill out!"
  | otherwise = "Whatever."
  where
    text = filter (not . isSpace) xs
    alpha = filter isAlpha text

    silence = null text
    yellingAQuestion = shouting && question
    question = "?" `isSuffixOf` text 
    shouting = (not . null $ alpha) && all isUpper alpha
