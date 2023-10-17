module Diamond (diamond) where

import Data.Char (isAlpha, isUpper, ord)

diamond :: Char -> Maybe [String]
diamond t
  | isAlpha t && isUpper t = Just $ mirrowH (firstLine t : map (`line` t) ['B' .. t])
  | otherwise = Nothing

distance :: Char -> Int
distance t = [1, 3 ..] !! (ord t - ord 'A' - 1)

firstLine :: Char -> String
firstLine t = mirrowV (indent 'A' t ++ "A")

line :: Char -> Char -> String
line f t = indent f t ++ [f] ++ concat (replicate (distance f) " ") ++ [f] ++ indent f t

indent :: Char -> Char -> String
indent f t = concat $ replicate (ord t - ord f) " "

mirrowV :: String -> String
mirrowV x = x ++ tail (reverse x)

mirrowH :: [String] -> [String]
mirrowH xs = xs ++ tail (reverse xs)
