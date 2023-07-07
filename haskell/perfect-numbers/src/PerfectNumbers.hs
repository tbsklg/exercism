module PerfectNumbers (classify, Classification (..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify x | x <= 0 = Nothing
classify x
  | aliqotSum == x = Just Perfect
  | aliqotSum > x = Just Abundant
  | otherwise = Just Deficient
  where
    aliqotSum = sum [y | y <- [1 .. (x `div` 2)], x `mod` y == 0]
