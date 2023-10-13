module PrimeFactors (primeFactors) where

primeFactors :: Integer -> [Integer]
primeFactors n = factors n $ 2 : [3, 5 ..]
 where
  factors 1 _ = []
  factors x (p : ps)
    | x `mod` p == 0 = p : factors (x `div` p) (p : ps)
    | otherwise = factors x ps
  factors _ _ = []
