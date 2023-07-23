module Robot
  ( Bearing (East, North, South, West),
    bearing,
    coordinates,
    mkRobot,
    move,
  )
where

data Bearing
  = North
  | East
  | South
  | West
  deriving (Eq, Show)

type Coordinate = (Integer, Integer)

data Robot = Robot {position :: Coordinate, direction :: Bearing} deriving (Show, Eq)

bearing :: Robot -> Bearing
bearing = direction

coordinates :: Robot -> (Integer, Integer)
coordinates = position

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction coordinates = Robot {position = coordinates, direction = direction}

move :: Robot -> String -> Robot
move robot [] = robot
move robot@Robot {position = (x, y), direction = North} ('A' : xs) = move (robot {position = (x, y + 1)}) xs
move robot@Robot {position = (x, y), direction = East} ('A' : xs) = move (robot {position = (x + 1, y)}) xs
move robot@Robot {position = (x, y), direction = South} ('A' : xs) = move (robot {position = (x, y - 1)}) xs
move robot@Robot {position = (x, y), direction = West} ('A' : xs) = move (robot {position = (x - 1, y)}) xs
move robot@Robot {direction = dir} (x : xs) = move (robot {direction = changeDirection dir x}) xs
  where
    changeDirection North 'R' = East
    changeDirection North 'L' = West
    changeDirection East 'R' = South
    changeDirection East 'L' = North
    changeDirection South 'R' = West
    changeDirection South 'L' = East
    changeDirection West 'R' = North
    changeDirection West 'L' = South
    changeDirection dir _ = dir
