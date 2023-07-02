module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, insertWith, empty)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts n = count n empty
    where
        count [] counts = Right counts
        count ('A':xs) counts = count xs (insertWith (+) A 1 counts)
        count ('C':xs) counts = count xs (insertWith (+) C 1 counts)
        count ('G':xs) counts = count xs (insertWith (+) G 1 counts)
        count ('T':xs) counts = count xs (insertWith (+) T 1 counts)
        count _ _ = Left "Not a valid nucleotide"
