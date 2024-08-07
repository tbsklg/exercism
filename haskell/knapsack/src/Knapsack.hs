module Knapsack (maximumValue) where

type MaxWeight = Int
type MaxValue = Int
type Weight = Int
type Value = Int
type Items = [(Weight, Value)]

maximumValue :: MaxWeight -> Items -> MaxValue
maximumValue _ [] = 0
maximumValue n ((w, v) : xs)
  | w > n = maximumValue n xs
  | otherwise = max (v + maximumValue (n - w) xs) (maximumValue n xs)
