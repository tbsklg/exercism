module Roman (numerals) where

import Control.Applicative (liftA2)

numerals :: Integer -> Maybe String
numerals n
  | n >= 1000 = liftA2 (++) (Just "M") (numerals (n - 1000))
  | n >= 900 = liftA2 (++) (Just "CM") (numerals (n - 900))
  | n >= 500 = liftA2 (++) (Just "D") (numerals (n - 500))
  | n >= 400 = liftA2 (++) (Just "CD") (numerals (n - 400))
  | n >= 100 = liftA2 (++) (Just "C") (numerals (n - 100))
  | n >= 90 = liftA2 (++) (Just "XC") (numerals (n - 90))
  | n >= 50 = liftA2 (++) (Just "L") (numerals (n - 50))
  | n >= 40 = liftA2 (++) (Just "XL") (numerals (n - 40))
  | n >= 10 = liftA2 (++) (Just "X") (numerals (n - 10))
  | n >= 9 = liftA2 (++) (numerals 1) (numerals 10)
  | n >= 5 = liftA2 (++) (Just "V") (numerals (n - 5))
  | n >= 4 = liftA2 (++) (numerals 1) (numerals 5)
  | n == 0 = Just ""
  | otherwise = liftA2 (++) (Just "I") (numerals (n - 1))

