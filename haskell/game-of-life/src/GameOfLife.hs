module GameOfLife (tick) where

import Data.List.Split (chunksOf)
import qualified Data.Vector as V

type Coordinate = (Int, Int)

type Board = V.Vector (V.Vector Cell)

type Neighbors = [Cell]

data Cell = Dead | Alive deriving (Eq)

tick :: [[Int]] -> [[Int]]
tick xs =
  let b = board xs
   in chunksOf (numberOfCols b)
        . map
          ( cellToInt
              . \(x, y) -> deadOrAlive (b V.! x V.! y) (neighbors (x, y) b)
          )
        $ [ (x, y)
            | x <- [0 .. numberOfRows b - 1],
              y <- [0 .. numberOfCols b - 1]
          ]

deadOrAlive :: Cell -> Neighbors -> Cell
deadOrAlive Alive xs =
  let alive = length . filter (== Alive) $ xs
   in if alive == 2 || alive == 3 then Alive else Dead
deadOrAlive Dead xs =
  let alive = length . filter (== Alive) $ xs
   in if alive == 3 then Alive else Dead

cells :: [Int] -> [Cell]
cells = map intToCell

intToCell :: Int -> Cell
intToCell 1 = Alive
intToCell 0 = Dead
intToCell _ = error "Unsupported integer for cell provided"

cellToInt :: Cell -> Int
cellToInt Alive = 1
cellToInt Dead = 0

board :: [[Int]] -> Board
board = V.fromList . map (V.fromList . cells)

neighbors :: Coordinate -> Board -> [Cell]
neighbors (rI, cI) b =
  [ (\(x', y') -> b V.! x' V.! y') (x, y)
    | x <- [(rI - 1) .. (rI + 1)],
      y <- [(cI - 1) .. (cI + 1)],
      (x, y) /= (rI, cI),
      isInRange (x, y) b
  ]

isInRange :: Coordinate -> Board -> Bool
isInRange (rI, cI) b = rI >= 0 && rI < numberOfRows b && cI >= 0 && cI < numberOfCols b

numberOfRows :: Board -> Int
numberOfRows = V.length

numberOfCols :: Board -> Int
numberOfCols b = maybe 0 V.length $ b V.!? 0
