module Change (findFewestCoins) where

import Control.Applicative ((<|>))
import Data.List (inits, minimumBy, sort)
import Data.Maybe (mapMaybe)
import Data.Ord (comparing)

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins 0 _ = Just []
findFewestCoins target coins
  | null validCombinations = Nothing
  | otherwise = Just . minimumBy (comparing length) $ validCombinations
  where
    validCombinations :: [[Integer]]
    validCombinations =
      mapMaybe (validCombination target)
        . filter (not . null)
        . inits
        . filter (<= target)
        $ coins
    
    validCombination :: Integer -> [Integer] -> Maybe [Integer]
    validCombination target coins = go target (reverse . sort $ coins) []
      where
        go 0 _ coinListAcc = Just coinListAcc
        go _ [] coinListAcc = Nothing
        go remainingAmount (coin : furtherCoins) coinListAcc
          | remainingAmount - coin < 0 = go remainingAmount furtherCoins coinListAcc
          | remainingAmount == coin = go 0 furtherCoins (remainingAmount : coinListAcc)
          | otherwise = go (remainingAmount - coin) (coin : furtherCoins) (coin : coinListAcc) <|> go remainingAmount furtherCoins coinListAcc
