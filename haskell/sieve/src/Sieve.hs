module Sieve (primesUpTo) where

-- You should not use any of the division operations when implementing
-- the sieve of Eratosthenes.

import Data.List ((\\))
import Prelude hiding (div, divMod, mod, quot, quotRem, rem, (/))

primesUpTo :: Integer -> [Integer]
primesUpTo n = sieve [2 .. n]
    where
        sieve [] = []
        sieve (x : xs) = x : sieve (xs \\ [x, x + x .. n])
