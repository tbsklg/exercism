module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year = divisibleBy 4 && (not (divisibleBy 100) || divisibleBy 400)
    where
        divisibleBy x = year `mod` x == 0
