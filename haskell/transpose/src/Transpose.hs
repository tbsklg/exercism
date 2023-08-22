module Transpose (transpose) where

import Safe (headMay, tailMay)
import Data.Maybe (fromMaybe)

transpose :: [String] -> [String]
transpose [] = []
transpose ls
    | all null ls = []
    | otherwise = concatMap firstCol ls : transpose (map furtherCols ls)
    where
        firstCol l = case headMay l of
            Nothing -> " "
            Just a -> [a]

        furtherCols l = fromMaybe [] (tailMay l)
