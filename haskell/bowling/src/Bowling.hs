module Bowling (score, BowlingError (..)) where

data BowlingError
  = IncompleteGame
  | InvalidRoll {rollIndex :: Int, rollValue :: Int}
  deriving (Eq, Show)

type Roll = Int
data State = State {frame :: Int, roll :: Roll, points :: Int}
  deriving (Eq, Show)

initialState :: State
initialState = State{frame = 1, roll = 0, points = 0}

score :: [Roll] -> Either BowlingError Int
score rolls = case validate rolls of
  Left e -> Left e
  Right rs -> play rs initialState
 where
  play [] State{frame = 11, points = p} = Right p
  play [s1, s2] State{frame = 10, points = p}
    | s1 == 10 || s1 + s2 == 10 = Left IncompleteGame
    | otherwise = Right $ p + s1 + s2
  play [_, _, s3, _] State{frame = 10, roll = r} =
    Left $ InvalidRoll{rollIndex = r + 3, rollValue = s3}
  play [10, s1, s2] State{frame = 10, roll = r, points = p}
    | s1 /= 10, s1 + s2 > 10 = Left $ InvalidRoll{rollIndex = r + 2, rollValue = s2}
    | otherwise = Right $ p + 10 + s1 + s2
  play [s1, s2, s3] State{frame = 10, roll = r, points = p}
    | s1 + s2 == 10 = Right $ p + 10 + s3
    | otherwise = Left $ InvalidRoll{rollIndex = r + 2, rollValue = s2}
  play (s1 : s2 : s3 : rs) state@State{frame = f, roll = r, points = p}
    | s1 == 10 = play (s2 : s3 : rs) state{frame = f + 1, roll = r + 1, points = p + 10 + s2 + s3}
    | s1 + s2 == 10 = play (s3 : rs) state{frame = f + 1, roll = r + 2, points = p + 10 + s3}
    | s1 + s2 < 10 = play (s3 : rs) state{frame = f + 1, roll = r + 2, points = p + s1 + s2}
    | otherwise = Left $ InvalidRoll{rollIndex = r, rollValue = s2}
  play (s1 : s2 : rs) state@State{frame = f, roll = r, points = p}
    | s1 == 10 = play (s2 : rs) state{frame = f + 1, roll = r + 1, points = p + 10 + s2}
    | s1 + s2 < 10 = play rs state{frame = f + 1, roll = r + 2, points = p + s1 + s2}
    | otherwise = Left $ InvalidRoll{rollIndex = r + 1, rollValue = s2}
  play _ _ = Left IncompleteGame

validate :: [Roll] -> Either BowlingError [Roll]
validate = mapM validate' . zip [0 ..]
 where
  validate' (i, r)
    | r < 0 || r > 10 = Left $ InvalidRoll{rollIndex = i, rollValue = r}
    | otherwise = Right r
