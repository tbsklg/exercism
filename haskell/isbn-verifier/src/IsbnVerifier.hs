module IsbnVerifier (isbn) where

import Control.Applicative ((<|>))
import Text.Parsec (char, digit, parse)
import Text.Parsec.Prim (ParsecT, many)
import Data.Functor.Identity (Identity)
import Text.Parsec.Combinator (eof)

isbn :: String -> Bool
isbn xs = case parse isbnParse "" xs of
  Left _ -> False
  Right digits -> (sum . zipWith (*) digits $ [10, 9 ..]) `mod` 11 == 0 

isbnParse :: ParsecT String u Identity [Int]
isbnParse = do
  x <- digit
  _ <- many $ char '-' 
  y1 <- digit
  y2 <- digit
  y3 <- digit
  _ <- many $ char '-' 
  z1 <- digit
  z2 <- digit
  z3 <- digit
  z4 <- digit
  z5 <- digit
  _ <- many $ char '-' 
  c <- digit <|> char 'X'
  eof 
  let checkDigit = if c == 'X' then 10 else read [c]
  return
    [ read [x] :: Int,
      read [y1] :: Int,
      read [y2] :: Int,
      read [y3] :: Int,
      read [z1] :: Int,
      read [z2] :: Int,
      read [z3] :: Int,
      read [z4] :: Int,
      read [z5] :: Int,
      checkDigit
    ]
