module Queens (boardString, canAttack) where

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines . placeQueen 'W' white . placeQueen 'B' black $ gameBoard
    where
        gameBoard :: [String]
        gameBoard = replicate 8 "_ _ _ _ _ _ _ _"

        placeQueen :: Char -> Maybe (Int, Int) -> [String] -> [String]
        placeQueen _ Nothing board = board
        placeQueen qeen (Just (x, y)) board = take x board ++ [updateRow qeen y (board !! x)] ++ drop (x + 1) board

        updateRow :: Char -> Int -> String -> String
        updateRow queen pos row = take (pos * 2) row ++ [queen] ++ drop (pos * 2 + 1) row

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (x, y) (x', y') = x == x' || y == y' || abs (x - x') == abs (y - y')
