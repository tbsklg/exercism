module SumOfMultiples (sumOfMultiples) where

import qualified Data.Set as S

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum . S.toList . foldl combine S.empty $ factors
  where
    combine y x = multiplesOf x `S.union` y

    multiplesOf 0 = S.fromList [0]
    multiplesOf n = S.fromList [x | x <- [n .. limit - 1], x `mod` n == 0]
