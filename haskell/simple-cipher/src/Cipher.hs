module Cipher (caesarDecode, caesarEncode, caesarEncodeRandom) where

import Data.Char (chr, ord)
import System.Random (randomRIO)

caesarDecode :: String -> String -> String
caesarDecode key encodedText = zipWith decodeChar encodedText (cycle key)
    where
        decodeChar c k = chr $ ord 'a' + (ord c - ord k) `mod` 26

caesarEncode :: String -> String -> String
caesarEncode key text = zipWith encodeChar text (cycle key)
    where
        encodeChar c k = chr $ ord 'a' + ((ord c + ord k - 194) `mod` 26)

caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
        key <- randomKey
        return (key, caesarEncode key text)
    where
        randomKey = sequence $ replicate 100 randomChar
        randomChar = do
                i <- randomRIO (0, 25)
                return $ chr $ ord 'a' + i
