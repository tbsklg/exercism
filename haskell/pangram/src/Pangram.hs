module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram xs = all (`elem` lowercase) ['a' .. 'z']
    where
        lowercase = map toLower xs
