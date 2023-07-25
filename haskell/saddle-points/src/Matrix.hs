module Matrix (saddlePoints) where

import Data.Array (Array, indices, (!), Ix)

saddlePoints :: (Ix i, Ord e, Show i) => Array (i, i) e -> [(i, i)]
saddlePoints matrix = filter isPerfectTree . indices $ matrix
  where
    isPerfectTree coordinate = isPerfectRow coordinate && isPerfectColumn coordinate

    isPerfectRow coordinate = all (\x -> (matrix ! coordinate) >= matrix ! x) . row $ coordinate
    isPerfectColumn coordinate = all (\x -> (matrix ! coordinate) <= matrix ! x) . column $ coordinate

    row coordinate = [x | x <- indices matrix, x /= coordinate, fst x == fst coordinate]
    column coordinate = [x | x <- indices matrix, x /= coordinate, snd x == snd coordinate]
