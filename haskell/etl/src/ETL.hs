module ETL (transform) where

import qualified Data.Map as M
import Data.Char (toLower)

transform :: (Num a, Show a) => M.Map a String -> M.Map Char a
transform = foldr (M.unionWith (+) . group) M.empty . M.toList
  where
    group (n, xs) = foldr ((`M.insert` n) . toLower) M.empty xs
