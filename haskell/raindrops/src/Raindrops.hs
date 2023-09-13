module Raindrops (convert) where

convert :: Int -> String
convert n
        | null drops = show n
        | otherwise = drops
    where
        drops = concatMap snd . filter fst $ [(mod3, "Pling"), (mod5, "Plang"), (mod7, "Plong")]
        mod3 = n `mod` 3 == 0
        mod5 = n `mod` 5 == 0
        mod7 = n `mod` 7 == 0
