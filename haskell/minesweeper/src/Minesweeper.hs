module Minesweeper (annotate) where

import Data.Char (intToDigit)
import Data.List.Split (chunksOf)

annotate :: [String] -> [String]
annotate [] = []
annotate [""] = [""]
annotate board = chunksOf numberOfColumns . map reveal $ coordinates
  where
    mine :: Char
    mine = '*'

    emptyField :: Char
    emptyField = ' '

    reveal :: (Int, Int) -> Char
    reveal c
      | isMine c = mine
      | numberOfMines c == 0 = emptyField
      | otherwise = intToDigit $ numberOfMines c

    isMine :: (Int, Int) -> Bool
    isMine (rI, cI) = board !! rI !! cI == mine

    numberOfMines :: (Int, Int) -> Int
    numberOfMines = length . filter (== mine) . neighbors

    coordinates :: [(Int, Int)]
    coordinates = [(x, y) | x <- [0 .. numberOfRows - 1], y <- [0 .. numberOfColumns - 1]]

    neighbors :: (Int, Int) -> String
    neighbors (rI, cI) =
      [ (\(x', y') -> board !! x' !! y') (x, y)
        | x <- [(rI - 1) .. (rI + 1)],
          y <- [(cI - 1) .. (cI + 1)],
          (x, y) /= (rI, cI),
          isInRange (x, y)
      ]

    isInRange :: (Int, Int) -> Bool
    isInRange (rI, cI) = rI >= 0 && rI < numberOfRows && cI >= 0 && cI < numberOfColumns

    numberOfRows :: Int
    numberOfRows = length board

    numberOfColumns :: Int
    numberOfColumns = length . head $ board
