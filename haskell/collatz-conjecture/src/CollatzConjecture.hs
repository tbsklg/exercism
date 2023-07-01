module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n 
    | n <= 0 = Nothing
    | n == 1 = Just 0
    | even n = (+1) <$> collatz (n `div` 2) 
    | otherwise = (+1) <$> collatz (n * 3 + 1)
