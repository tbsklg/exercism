module Minesweeper (annotate) where

import Data.Char (intToDigit)
import Data.List.Split (chunksOf)
import qualified Data.Vector as V

type Coordinate = (Int, Int)

type Board = [String]

annotate :: Board -> Board
annotate [""] = [""]
annotate board = annotate' . V.fromList . map V.fromList $ board

annotate' :: V.Vector (V.Vector Char) -> Board
annotate' board = chunksOf numberOfColumns . map reveal $ boardCoordinates 
  where
    mine :: Char
    mine = '*'

    emptyField :: Char
    emptyField = ' '

    reveal :: Coordinate -> Char
    reveal c
      | isMine c = mine
      | numberOfMines == 0 = emptyField
      | otherwise = intToDigit numberOfMines
      where
        numberOfMines = countMines c

    isMine :: Coordinate -> Bool
    isMine (rI, cI) = board V.! rI V.! cI == mine

    countMines :: Coordinate -> Int
    countMines = length . filter (== mine) . neighbors

    boardCoordinates :: [Coordinate]
    boardCoordinates = [(x, y) | x <- [0 .. numberOfRows - 1], y <- [0 .. numberOfColumns - 1]]

    neighbors :: Coordinate -> String
    neighbors (rI, cI) =
      [ (\(x', y') -> board V.! x' V.! y') (x, y)
        | x <- [(rI - 1) .. (rI + 1)],
          y <- [(cI - 1) .. (cI + 1)],
          (x, y) /= (rI, cI),
          isInRange (x, y)
      ]

    isInRange :: Coordinate -> Bool
    isInRange (rI, cI) = rI >= 0 && rI < numberOfRows && cI >= 0 && cI < numberOfColumns

    numberOfRows :: Int
    numberOfRows = V.length board 

    numberOfColumns :: Int
    numberOfColumns = maybe 0 V.length $ board V.!? 0
