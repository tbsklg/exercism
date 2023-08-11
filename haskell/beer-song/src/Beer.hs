module Beer (song) where

song :: String
song = concat [beer x | x <- [99, 98 .. 0]]

beer :: (Eq a, Num a, Show a) => a -> [Char]
beer n = currentBottles n ++ ", " ++ ofBeer n ++ ".\n" ++ takeOneDown n ++ ", " ++ remainingBottles (n - 1) ++ "\n"

takeOneDown :: (Eq a, Num a) => a -> [Char]
takeOneDown 0 = "Go to the store and buy some more"
takeOneDown 1 = "Take it down and pass it around"
takeOneDown _ = "Take one down and pass it around"

currentBottles :: (Eq a, Num a, Show a) => a -> String
currentBottles 0 = "No more bottles of beer on the wall"
currentBottles 1 = "1 bottle of beer on the wall"
currentBottles n = show n ++ " bottles of beer on the wall"

remainingBottles :: (Eq a, Num a, Show a) => a -> [Char]
remainingBottles 0 = "no more bottles of beer on the wall.\n"
remainingBottles (-1) = "99 bottles of beer on the wall" ++ "."
remainingBottles 1 = "1 bottle of beer on the wall.\n"
remainingBottles n = show n ++ " bottles of beer on the wall.\n"

ofBeer :: (Eq a, Num a, Show a) => a -> [Char]
ofBeer 0 = "no more bottles of beer"
ofBeer 1 = "1 bottle of beer"
ofBeer n = show n ++ " bottles of beer"
