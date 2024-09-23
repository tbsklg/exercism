module WordSearch (search, CharPos (..), WordPos (..)) where

import Control.Applicative
import Data.List (findIndex, isPrefixOf, tails, transpose)

data CharPos = CharPos {col :: Int, row :: Int} deriving (Eq, Show)
data WordPos = WordPos {start :: CharPos, end :: CharPos} deriving (Eq, Show)

search :: [String] -> [String] -> [(String, Maybe WordPos)]
search [] _ = []
search _ [] = []
search grid (w : ws) =
  let
    horizontals = indexed grid
    verticals = indexed $ transpose grid

    scanHor [] = Nothing
    scanHor ((i, l) : ls) =
      case findWord w l of
        Nothing -> scanHor ls
        Just (f, t) -> Just (w, Just $ WordPos (CharPos f i) (CharPos t i))

    scanVer [] = Nothing
    scanVer ((i, l) : ls) =
      case findWord w l of
        Nothing -> scanVer ls
        Just (f, t) -> Just (w, Just $ WordPos (CharPos i f) (CharPos i t))
   in
    case scanHor horizontals <|> scanVer verticals of
      Nothing -> (w, Nothing) : search grid ws
      Just r -> r : search grid ws

indexed :: [a] -> [(Int, a)]
indexed = zip [1 ..]

findWord :: String -> String -> Maybe (Int, Int)
findWord w l = rightToLeft w l <|> leftToRight w l

rightToLeft :: String -> String -> Maybe (Int, Int)
rightToLeft = findWordInLine

leftToRight :: String -> String -> Maybe (Int, Int)
leftToRight w l = case findWordInLine (reverse w) l of
  Nothing -> Nothing
  Just (f, t) -> Just (t, f)

findWordInLine :: String -> String -> Maybe (Int, Int)
findWordInLine w l
  | length w > length l = Nothing
  | otherwise = case findIndex (isPrefixOf w) (tails l) of
      Nothing -> Nothing
      Just i -> Just (i + 1, i + length w)
