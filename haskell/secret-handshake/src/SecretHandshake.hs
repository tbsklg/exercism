module SecretHandshake (handshake) where

import Data.Bits (testBit)

handshake :: Int -> [String]
handshake n
  | testBit n 4 = reverse xs
  | otherwise = xs
  where
    xs =
      ["wink" | testBit n 0]
        ++ ["double blink" | testBit n 1]
        ++ ["close your eyes" | testBit n 2]
        ++ ["jump" | testBit n 3]
