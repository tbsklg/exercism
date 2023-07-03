module Grains (square, total) where

square :: Integer -> Maybe Integer
square 0 = Nothing
square n
  | n <= 0 || n > 64 = Nothing
  | otherwise = Just $ iterate (* 2) 1 !! fromIntegral (n - 1)

total :: Integer
total = 18446744073709551615
