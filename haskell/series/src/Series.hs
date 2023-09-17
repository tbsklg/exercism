module Series (slices) where

import Data.Char (digitToInt)
import Data.List (tails)

slices :: Int -> String -> [[Int]]
slices n = map (take n) . filter ((>= n) . length) . tails . map digitToInt
