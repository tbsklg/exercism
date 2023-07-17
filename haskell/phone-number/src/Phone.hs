module Phone (number) where

import Data.Char (isDigit)
import Text.Parsec
  ( char,
    count,
    digit,
    eof,
    noneOf,
    parse,
    skipMany,
  )
import Text.Printf (printf)

number :: String -> Maybe String
number xs = case parse phoneNumber "" (filter isDigit xs) of
  Left _ -> Nothing
  Right pn -> Just pn
  where
    phoneNumber = do
      skipMany $ char '1'
      planArea <- noneOf "0"
      planAreaCode <- count 2 digit
      exchange <- noneOf "01"
      exchangeCode <- count 2 digit
      subscriberNumber <- count 4 digit
      eof
      return $ printf "%s%s%s" (planArea : planAreaCode) (exchange : exchangeCode) subscriberNumber
