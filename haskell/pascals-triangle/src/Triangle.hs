module Triangle (rows) where

rows :: Int -> [[Integer]]
rows x = take x . iterate triangle $ [1]
  where
    triangle n = 1 : zipWith (+) n (tail n) ++ [1]
