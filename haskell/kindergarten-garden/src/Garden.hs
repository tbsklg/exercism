module Garden (
    Plant (..),
    garden,
    lookupPlants,
) where

import qualified Data.Map as M
import Data.List (transpose)
import Data.List.Split (chunksOf)

data Plant
    = Clover
    | Grass
    | Radishes
    | Violets
    deriving (Eq, Show)

type Student = String
type Garden = M.Map Student [Plant]

garden :: [Student] -> String -> Garden
garden students plants = foldr (\(student, plants) garden -> M.insertWith (++) student plants garden) M.empty $ zip students $ parsePlants plants
  where
    parsePlants :: String -> [[Plant]]
    parsePlants = map (map parsePlant . concat) . transpose . map (chunksOf 2) . lines
      where
        parsePlant :: Char -> Plant
        parsePlant 'C' = Clover
        parsePlant 'G' = Grass
        parsePlant 'R' = Radishes
        parsePlant 'V' = Violets
        parsePlant _ = error "Invalid plant code"

lookupPlants :: String -> Garden -> [Plant]
lookupPlants student garden = M.findWithDefault [] student garden
