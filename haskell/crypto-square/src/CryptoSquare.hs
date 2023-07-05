module CryptoSquare (encode) where

import Data.Char (isAlphaNum, toLower)
import Data.List (transpose)
import Data.List.Split (chunksOf)

encode :: String -> String
encode message = unwords . transpose . map pad . chunksOf columnLength $ normalized
  where
    columnLength = ceiling . sqrt . fromIntegral . length $ normalized
    normalized = map toLower . filter isAlphaNum $ message
    pad chunk = chunk ++ replicate (columnLength - length chunk) ' '
