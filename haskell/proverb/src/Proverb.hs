module Proverb(recite) where
    
import Text.Printf (printf)
import Data.List (intercalate)

recite :: [String] -> String
recite [] = []
recite i@(x:_) = intercalate "\n" (verses ++ [end])
    where
        end = printf "And all for the want of a %s." x
        verses = zipWith verse i . tail $ i 
        verse = printf "For want of a %s the %s was lost."
