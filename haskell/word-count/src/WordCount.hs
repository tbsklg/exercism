module WordCount (wordCount) where

import qualified Data.Map as M
import Data.Char (toLower)
import Data.List.Split (wordsBy)

wordCount :: String -> [(String, Int)]
wordCount = M.toList . foldl (\y x -> M.insertWith (+) x 1 y) M.empty . map (removeQuotation . map toLower) . wordsBy (`elem` "\n,.;!?&$@%^: ")
    where
        removeQuotation ('\'':xs) = reverse . removeQuotation . reverse $ xs
        removeQuotation xs = xs
