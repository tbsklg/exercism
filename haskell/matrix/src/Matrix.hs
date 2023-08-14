{-# HLINT ignore "Use newtype instead of data" #-}
module Matrix
  ( Matrix,
    cols,
    column,
    flatten,
    fromString,
    reshape,
    fromList,
    row,
    rows,
    shape,
    transpose,
  )
where

import qualified Data.List as L
import qualified Data.Vector  as V
import Data.Vector (Vector)
import Safe (headMay)

data Matrix a = Matrix [[a]] deriving (Eq, Show)

cols :: Matrix a -> Int
cols (Matrix a) = maybe 0 length (headMay a)

column :: Int -> Matrix a -> Vector a
column x (Matrix a) = V.fromList . map (\r -> r !! (x - 1)) $ a

flatten :: Matrix a -> Vector a
flatten (Matrix a) = V.fromList . concat $ a

fromList :: [[a]] -> Matrix a
fromList = Matrix

fromString :: String -> Matrix Int
fromString = Matrix . map (map read . words) . lines

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape (r, c) (Matrix a) = Matrix . take r . reshape' . concat $ a
  where
    reshape' [] = []
    reshape' xs = take c xs : reshape' (drop c xs)

row :: Int -> Matrix a -> Vector a
row x (Matrix a) = V.fromList $ a !! (x - 1)

rows :: Matrix a -> Int
rows (Matrix a) = length a

shape :: Matrix a -> (Int, Int)
shape matrix = (rows matrix, cols matrix)

transpose :: Matrix a -> Matrix a
transpose (Matrix xs) = Matrix . L.transpose $ xs
