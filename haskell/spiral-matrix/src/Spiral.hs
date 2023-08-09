module Spiral (spiral) where

data Direction = R | D | L | U deriving (Show, Eq)

spiral :: Int -> [[Int]]
spiral 0 = []
spiral dim = fill 1 (0, 0) (cycle clockWise) (emptyMatrix dim)
  where
    fill :: Int -> (Int, Int) -> [Direction] -> [[Int]] -> [[Int]]
    fill _ _ [] [] = []
    fill v (x, y) _ m | v == dim * dim = setValue v (x, y) m
    fill v (x, y) (R : ds) m
      | y < dim - 1 && m !! x !! (y + 1) == 0 = fill (v + 1) (x, y + 1) (R : ds) (setValue v (x, y) m)
      | otherwise = fill v (x, y) ds m
    fill v (x, y) (D : ds) m
      | x < dim - 1 && m !! (x + 1) !! y == 0 = fill (v + 1) (x + 1, y) (D : ds) (setValue v (x, y) m)
      | otherwise = fill v (x, y) ds m
    fill v (x, y) (L : ds) m
      | y > 0 && m !! x !! (y - 1) == 0 = fill (v + 1) (x, y - 1) (L : ds) (setValue v (x, y) m)
      | otherwise = fill v (x, y) ds m
    fill v (x, y) (U : ds) m
      | x > 0 && m !! (x - 1) !! y == 0 = fill (v + 1) (x - 1, y) (U : ds) (setValue v (x, y) m)
      | otherwise = fill v (x, y) ds m
    fill _ _ _ _ = []

    clockWise = [R, D, L, U]

emptyMatrix :: Num a => Int -> [[a]]
emptyMatrix dim = replicate dim . replicate dim $ 0

setValue :: a -> (Int, Int) -> [[a]] -> [[a]]
setValue v (x, y) m = take x m ++ [take y row ++ [v] ++ drop (y + 1) row] ++ drop (x + 1) m
  where
    row = m !! x
