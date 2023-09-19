module RailFenceCipher (encode, decode) where

import Data.List (sortBy)
import Data.Ord (comparing)

encode :: Int -> String -> String
encode key = map snd . sortBy (comparing fst) . zip rail
    where
        rail = cycle ([0 .. key - 2] ++ [key - 1, key - 2 .. 1])

decode :: Int -> String -> String
decode key xs = map snd . sortBy (comparing fst) . zip rail $ xs
    where
        rail = map snd . sortBy (comparing fst) . zip (cycle ([0 .. key - 2] ++ [key - 1, key - 2 .. 1])) $ [0 .. length xs - 1]
