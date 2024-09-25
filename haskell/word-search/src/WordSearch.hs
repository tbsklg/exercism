module WordSearch (search, CharPos (..), WordPos (..)) where

import Control.Applicative ()
import Data.List (elemIndices)

data CharPos = CharPos {col :: Int, row :: Int} deriving (Eq, Show)

data WordPos = WordPos {start :: CharPos, end :: CharPos} deriving (Eq, Show)

search :: [String] -> [String] -> [(String, Maybe WordPos)]
search _ [] = []
search grid (w : ws) =
  let startPositions :: [(Int, Int)]
      startPositions = maybe [] findPositions (safeHead w)

      inBounds :: (Int, Int) -> Bool
      inBounds (r, c) = r >= 0 && r < length grid && c >= 0 && c < length (head grid)

      findPositions :: Char -> [(Int, Int)]
      findPositions c =
        let fp [] = []
            fp ((i, l) : ls) = [(i, j) | j <- elemIndices c l] ++ fp ls
         in fp (zip [0 ..] grid)

      go :: [(Int, Int)] -> [(String, Maybe WordPos)]
      go [] = []
      go ((r, c) : ps) =
        let leftToRight = [(r, c') | c' <- [c .. c + length w - 1], inBounds (r, c')]
            rightToLeft = [(r, c') | c' <- [c, c - 1 .. c - length w - 1], inBounds (r, c')]
            topToBottom = [(r', c) | r' <- [r .. r + length w - 1], inBounds (r', c)]
            bottomToTop = [(r', c) | r' <- [r, r - 1 .. r - length w + 1], inBounds (r', c)]
            topLeftBottomRight = filter inBounds $ zip [r .. r + length w - 1] [c .. c + length w - 1]
            bottomRightTopLeft = filter inBounds $ zip [r, r - 1 .. r - length w + 1] [c, c - 1 .. c - length w - 1]
            topRightBottomLeft = filter inBounds $ zip [r .. r + length w - 1] [c, c - 1 .. c - length w - 1]
            bottomLeftTopRight = filter inBounds $ zip [r, r - 1 .. r - length w + 1] [c .. c + length w - 1]

            foundWords =
              filter
                (\ys -> map (\(x, y) -> grid !! x !! y) ys == w)
                [leftToRight, rightToLeft, topToBottom, bottomToTop, topLeftBottomRight, bottomRightTopLeft, topRightBottomLeft, bottomLeftTopRight]
         in case foundWords of
              [] -> go ps
              (ys : _) -> (w, Just $ WordPos {start = s, end = e}) : go ps
                where
                  s = CharPos {col = c + 1, row = r + 1}
                  e = CharPos {col = snd (last ys) + 1, row = fst (last ys) + 1}

      result :: [(String, Maybe WordPos)]
      result = go startPositions
   in if null startPositions || null result
        then (w, Nothing) : search grid ws
        else go startPositions ++ search grid ws

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x : _) = Just x
