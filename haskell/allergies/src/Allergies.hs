module Allergies (Allergen (..), allergies, isAllergicTo) where

import Data.Bits (testBit)

data Allergen
        = Eggs
        | Peanuts
        | Shellfish
        | Strawberries
        | Tomatoes
        | Chocolate
        | Pollen
        | Cats
        deriving (Eq, Show, Enum)

allergies :: Int -> [Allergen]
allergies n = filter (`isAllergicTo` n) [Eggs .. Cats]

isAllergicTo :: Allergen -> Int -> Bool
isAllergicTo a n = testBit n (fromEnum a)
