module OCR (convert) where

import Data.Maybe (fromMaybe)
import Data.List.Split (chunksOf)
import Data.List (intercalate)

convert :: String -> String
convert = intercalate "," . map (toDigit . extractOcrs) . chunksOf 4 . lines

toDigit :: [String] -> String
toDigit = concatMap (\x -> fromMaybe "?" (lookup x ocrMappings))

extractOcrs :: [String] -> [String]
extractOcrs xs
  | all (== "") xs = []
  | otherwise = concatMap (take 3) xs : (extractOcrs . map (drop 3) $ xs)

ocrMappings :: [(String, String)]
ocrMappings =
  [ (" _ | ||_|   ", "0"),
    ("     |  |   ", "1"),
    (" _  _||_    ", "2"),
    (" _  _| _|   ", "3"),
    ("   |_|  |   ", "4"),
    (" _ |_  _|   ", "5"),
    (" _ |_ |_|   ", "6"),
    (" _   |  |   ", "7"),
    (" _ |_||_|   ", "8"),
    (" _ |_| _|   ", "9")
  ]
