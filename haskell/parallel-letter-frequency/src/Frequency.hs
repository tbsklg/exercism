module Frequency (frequency) where

import Data.Char (isAlpha)
import qualified Data.Map as M
import qualified Data.Text as T

frequency :: Int -> [T.Text] -> M.Map Char Int
frequency _ = foldr ((M.unionWith (+) . countChars) . T.toLower) M.empty
  where
    countChars :: T.Text -> M.Map Char Int
    countChars t = case T.uncons t of
      Nothing -> M.empty
      Just (h, r) -> addChar (h, r)

    addChar (h, r)
      | isAlpha h = M.insertWith (+) h 1 (countChars r)
      | otherwise = countChars r
