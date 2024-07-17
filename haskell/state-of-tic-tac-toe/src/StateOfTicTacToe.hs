module StateOfTicTacToe (gameState, GameState (..)) where

import Data.List (transpose)

data GameState = WinX | WinO | Draw | Ongoing | Impossible deriving (Eq, Show)

gameState :: [String] -> GameState
gameState board
  | isImpossible = Impossible
  | winX = WinX
  | winO = WinO
  | isDraw = Draw
  | otherwise = Ongoing
  where
    winX :: Bool
    winX = win 'X'

    winO :: Bool
    winO = win 'O'

    win :: Char -> Bool
    win player =
      winHorizontally player
        || winVertically player
        || winDiagonally player

    isDraw :: Bool
    isDraw = countX + countO == 9

    isImpossible :: Bool
    isImpossible =
      win 'X' && win 'O' || wentTwice || oStarted
      where
        wentTwice = countX - countO > 1
        oStarted = countO > countX

    countPlayer :: Char -> Int
    countPlayer player = length . filter (== player) . concat $ board

    countX :: Int
    countX = countPlayer 'X'

    countO :: Int
    countO = countPlayer 'O'

    winHorizontally :: Char -> Bool
    winHorizontally player =
      any (\row -> [player, player, player] == filter (== player) row) board

    winVertically :: Char -> Bool
    winVertically player =
      any (\row -> [player, player, player] == filter (== player) row) . transpose $ board

    winDiagonally :: Char -> Bool
    winDiagonally player =
      [board !! 0 !! 0, board !! 1 !! 1, board !! 2 !! 2] == [player, player, player]
        || [board !! 0 !! 2, board !! 1 !! 1, board !! 2 !! 0] == [player, player, player]
