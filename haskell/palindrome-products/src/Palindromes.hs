module Palindromes (largestPalindrome, smallestPalindrome) where

largestPalindrome :: Integer -> Integer -> Maybe (Integer, [(Integer, Integer)])
largestPalindrome minFactor maxFactor = if null xs then Nothing else Just (x, xs)
    where
        x = maximum . map (uncurry (*)) $ ps
        xs = filter ((== x) . uncurry (*)) ps
        ps = products minFactor maxFactor

smallestPalindrome :: Integer -> Integer -> Maybe (Integer, [(Integer, Integer)])
smallestPalindrome minFactor maxFactor = if null xs then Nothing else Just (x, xs)
    where
        x = minimum . map (uncurry (*)) $ ps
        xs = filter ((== x) . uncurry (*)) ps
        ps = products minFactor maxFactor

products :: Integer -> Integer -> [(Integer, Integer)]
products minFactor maxFactor = [(x, y) | x <- [minFactor .. maxFactor], y <- [x .. maxFactor], isPalindrome (x * y)]

isPalindrome :: Integer -> Bool
isPalindrome n = reverse (show n) == show n
