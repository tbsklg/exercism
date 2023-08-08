module RotationalCipher (rotate) where
import Data.Char (ord, chr, isLower, isUpper)

rotate :: Int -> String -> String
rotate i = map rotateChar
    where
        rotateChar c
            | isLower c = chr $ ord 'a' + (ord c - ord 'a' + i) `mod` 26
            | isUpper c = chr $ ord 'A' + (ord c - ord 'A' + i) `mod` 26
            | otherwise = c