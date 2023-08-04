module ProteinTranslation (proteins) where

import Data.List.Split (chunksOf)

proteins :: String -> Maybe [String]
proteins = proteins' . chunksOf 3
  where
    proteins' [] = Just []
    proteins' (x : xs) = case lookup x codonToProtein of
      Nothing -> Nothing
      Just protein -> if protein == "STOP" then Just [] else (protein :) <$> proteins' xs

codonToProtein :: [(String, String)]
codonToProtein =
  [ ("AUG", "Methionine"),
    ("UUU", "Phenylalanine"),
    ("UUC", "Phenylalanine"),
    ("UUA", "Leucine"),
    ("UUG", "Leucine"),
    ("UCU", "Serine"),
    ("UCC", "Serine"),
    ("UCA", "Serine"),
    ("UCG", "Serine"),
    ("UAU", "Tyrosine"),
    ("UAC", "Tyrosine"),
    ("UGU", "Cysteine"),
    ("UGC", "Cysteine"),
    ("UGG", "Tryptophan"),
    ("UAA", "STOP"),
    ("UAG", "STOP"),
    ("UGA", "STOP")
  ]
