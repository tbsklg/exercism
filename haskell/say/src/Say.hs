module Say (inEnglish) where

thousands :: [String]
thousands =
  [ "hundred"
  , "thousand"
  , "million"
  , "billion"
  , "trillion"
  ]

tens :: [String]
tens =
  [ "twenty"
  , "thirty"
  , "forty"
  , "fifty"
  , "sixty"
  , "seventy"
  , "eighty"
  , "ninety"
  ]

ones :: [String]
ones =
  [ "zero"
  , "one"
  , "two"
  , "three"
  , "four"
  , "five"
  , "six"
  , "seven"
  , "eight"
  , "nine"
  , "ten"
  ]

teens :: [String]
teens =
  [ "eleven"
  , "twelve"
  , "thirteen"
  , "fourteen"
  , "fifteen"
  , "sixteen"
  , "seventeen"
  , "eighteen"
  , "nineteen"
  ]

inEnglish :: Integer -> Maybe String
inEnglish n
  | n < 0 = Nothing
  | otherwise = Just $ say n

say :: Integer -> String
say n
  | n < 11 = ones !! fromIntegral n
  | n < 20 = teens !! fromIntegral (n - 11)
  | n < 100 && n `mod` 10 == 0 = tens !! fromIntegral (n `div` 10 - 2)
  | n < 100 = tens !! fromIntegral (n `div` 10 - 2) ++ "-" ++ say (n `mod` 10)
  | n < 1000 && n `mod` 100 == 0 = say (n `div` 100) ++ " " ++ head thousands
  | n < 1000 = say (n `div` 100) ++ " " ++ head thousands ++ " " ++ say (n `mod` 100)
  | n < 1000000 && n `mod` 1000 == 0 = say (n `div` 1000) ++ " " ++ thousands !! 1
  | n < 1000000 = say (n `div` 1000) ++ " " ++ thousands !! 1 ++ " " ++ say (n `mod` 1000)
  | n < 1000000000 && n `mod` 1000000 == 0 = say (n `div` 1000000) ++ " " ++ thousands !! 2
  | n < 1000000000 = say (n `div` 1000000) ++ " " ++ thousands !! 2 ++ " " ++ say (n `mod` 1000000)
  | n < 1000000000000 && n `mod` 1000000000 == 0 = say (n `div` 1000000000) ++ " " ++ thousands !! 3
  | n < 1000000000000 = say (n `div` 1000000000) ++ " " ++ thousands !! 3 ++ " " ++ say (n `mod` 1000000000)
  | otherwise = say (n `div` 1000000000000) ++ " " ++ thousands !! 4 ++ " " ++ say (n `mod` 1000000000000)
