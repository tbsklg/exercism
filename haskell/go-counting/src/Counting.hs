module Counting (
  Color (..),
  territories,
  territoryFor,
) where

import Data.Array
import Data.List (nub)
import Data.Maybe (fromMaybe, mapMaybe)
import Safe (headMay)

import qualified Data.Set as S

data Color = Black | White deriving (Eq, Ord, Show)
type Coord = (Int, Int)
type GameBoard = Array (Int, Int) Char

territories :: [String] -> [(S.Set Coord, Maybe Color)]
territories rows =
  nub
    . mapMaybe (territoryFor rows)
    . S.toList
    $ intersections (asGameBoard rows)

territoryFor :: [String] -> Coord -> Maybe (S.Set Coord, Maybe Color)
territoryFor rows coord = territoryFor' (asGameBoard rows)
 where
  territoryFor' :: GameBoard -> Maybe (S.Set Coord, Maybe Color)
  territoryFor' board
    | not pointsToEmptyLocation = Nothing
    | otherwise = Just (area, owner)
   where
    pointsToEmptyLocation :: Bool
    pointsToEmptyLocation =
      coord `elem` intersections board

    area :: S.Set Coord
    area = head . filter (S.member coord) $ areas board

    owner :: Maybe Color
    owner = ownedBy $ frontiersOf board area

asGameBoard :: [String] -> GameBoard
asGameBoard rows =
  array
    ((1, 1), (h, v))
    [ ((x, y), rows !! (y - 1) !! (x - 1)) | x <- [1 .. h], y <- [1 .. v]
    ]
 where
  h :: Int
  h = length . fromMaybe [] . headMay $ rows

  v :: Int
  v = length rows

intersections :: GameBoard -> S.Set Coord
intersections = S.fromList . map fst . filter ((==) ' ' . snd) . assocs

toColor :: Char -> Maybe Color
toColor 'W' = Just White
toColor 'B' = Just Black
toColor _ = Nothing

adjacents :: GameBoard -> Coord -> [Coord]
adjacents board (x, y) =
  filter
    (inBounds board)
    [ (x + 1, y)
    , (x - 1, y)
    , (x, y + 1)
    , (x, y - 1)
    ]

inBounds :: GameBoard -> Coord -> Bool
inBounds board (x, y) = x >= 1 && x <= h && y >= 1 && y <= v
 where
  ((_, _), (h, v)) = bounds board

areas :: GameBoard -> [S.Set Coord]
areas board = findAreas . intersections $ board
 where
  findAreas :: S.Set Coord -> [S.Set Coord]
  findAreas fields
    | S.null fields = []
    | otherwise = area : findAreas empties
   where
    (area, empties) = expandArea board (S.singleton start) (S.delete start fields)

    start :: Coord
    start = head . S.toList $ fields

expandArea :: GameBoard -> S.Set Coord -> S.Set Coord -> (S.Set Coord, S.Set Coord)
expandArea board area unoccupied
  | S.null neighbours = (area, unoccupied)
  | otherwise = expandArea board (S.union area neighbours) unoccupied'
 where
  (neighbours, unoccupied') = S.partition allocate unoccupied
   where
    allocate :: Coord -> Bool
    allocate = any (`S.member` area) . adjacents board

frontiersOf :: GameBoard -> S.Set Coord -> S.Set (Maybe Color)
frontiersOf board area =
  S.fromList
    . map toColor
    . filter (/= ' ')
    . map (board !)
    . concatMap (adjacents board)
    $ frontiers'
 where
  frontiers' :: [Coord]
  frontiers' = S.toList . S.filter isFrontier $ area

  isFrontier :: Coord -> Bool
  isFrontier coord = any (`S.notMember` area) (adjacents board coord)

ownedBy :: S.Set (Maybe Color) -> Maybe Color
ownedBy frontiers
  | S.null frontiers = Nothing
  | S.size frontiers == 1 = head . S.toList $ frontiers
  | otherwise = Nothing
