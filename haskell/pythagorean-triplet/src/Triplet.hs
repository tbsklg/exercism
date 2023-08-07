module Triplet (tripletsWithSum) where

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum xs =
  map (\(a, b, c) -> (min a b, max a b, c)) $
    [ (a, b, c)
      | m <- [2 .. xs `div` 3],
        n <- [1 .. m - 1],
        k <- [1 .. xs `div` (m + n)],
        let a = k * (m ^ 2 - n ^ 2),
        let b = k * (2 * m * n),
        let c = k * (m ^ 2 + n ^ 2),
        a ^ 2 + b ^ 2 == c ^ 2,
        a + b + c == xs,
        gcd m n == 1,
        even m || even n
    ]
