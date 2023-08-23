module Transpose (transpose) where

import Safe (headMay, tailMay)
import Data.Maybe (fromMaybe)

transpose :: [String] -> [String]
transpose [] = []
transpose lines = go lines 0
  where
    go (l:ls) g =
      | 

    currentLenght = length l
