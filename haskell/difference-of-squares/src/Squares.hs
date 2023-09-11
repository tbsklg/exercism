module Squares (difference, squareOfSum, sumOfSquares) where

difference :: Integral a => a -> a
difference n = squareOfSum n - sumOfSquares n

squareOfSum :: Integral a => a -> a
squareOfSum n = (n * (n + 1) `div` 2) ^ (2 :: Integer)

sumOfSquares :: Integral a => a -> a
sumOfSquares n = sum . map (^ (2 :: Integer)) $ [1 .. n]
