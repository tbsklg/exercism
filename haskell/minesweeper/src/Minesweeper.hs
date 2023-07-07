module Minesweeper (annotate) where

import Data.Char (intToDigit)
import Data.Maybe (catMaybes)

annotate :: [String] -> [String]
annotate board = reveal . zip [0 ..] $ board
  where
    reveal [] = []
    reveal ((rI, r) : rs) = zipWith (\cI v -> countMines ((rI, cI), v)) [0 ..] r : reveal rs

    countMines ((rI, cI), ' ')
      | null numberOfMines = ' '
      | otherwise = intToDigit $ length numberOfMines
      where
        numberOfMines = filter (== '*') . neighbors $ (rI, cI)
    countMines (_, v) = v

    neighbors (rI, cI) = catMaybes [ul, u, ur, r, dr, d, dl, l]
      where
        ul = valueOf (rI - 1, cI - 1)
        u = valueOf (rI - 1, cI)
        ur = valueOf (rI - 1, cI + 1)
        r = valueOf (rI, cI + 1)
        dr = valueOf (rI + 1, cI + 1)
        d = valueOf (rI + 1, cI)
        dl = valueOf (rI + 1, cI - 1)
        l = valueOf (rI, cI - 1)

    valueOf (rI, cI)
      | isOutOfBound = Nothing
      | otherwise = Just $ board !! rI !! cI
      where
        isOutOfBound = rI < 0 || rI > (numberOfRows - 1) || cI < 0 || cI > (numberOfColumns - 1)

    numberOfRows = length board
    numberOfColumns = length . head $ board
