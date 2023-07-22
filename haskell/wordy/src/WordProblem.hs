module WordProblem (answer) where

import Text.Parsec (ParsecT, char, digit, eof, letter, many1, parse, skipMany, space, string, (<|>), many, try)
import Data.Functor.Identity (Identity)

data Operation = Addition | Multiplication | Subtraction | Division deriving (Show, Eq)

answer :: String -> Maybe Integer
answer problem = case parse parseOperation "" problem of
  Left _ -> Nothing
  Right x -> Just x

parseOperation :: ParsecT String u Identity Integer
parseOperation = do
  string "What is "
  n <- parseNumber
  operations <- many parseChainedOperation
  char '?'
  eof
  return $ foldl (\y (operation, x) -> applyOperation operation y x) n operations

parseChainedOperation :: ParsecT String u Identity (Operation, Integer)
parseChainedOperation = do
  space
  operation <- parseAddition <|> parseSubtraction <|> parseMultiplication <|> parseDivision
  space
  number <- parseNumber
  return (operation, number)

applyOperation :: Operation -> Integer -> Integer -> Integer
applyOperation Addition x y = x + y
applyOperation Multiplication x y = x * y
applyOperation Subtraction x y = x - y
applyOperation Division x y = x `div` y

parseAddition :: ParsecT String u Identity Operation
parseAddition = try (string "plus") >> return Addition

parseMultiplication :: ParsecT String u Identity Operation
parseMultiplication = try (string "multiplied by") >> return Multiplication

parseSubtraction :: ParsecT String u Identity Operation
parseSubtraction = try (string "minus") >> return Subtraction

parseDivision :: ParsecT String u Identity Operation
parseDivision = try (string "divided by") >> return Division

parseNumber :: ParsecT String u Identity Integer
parseNumber =
  do
    char '-'
    n <- read <$> many1 digit
    return (-n)
    <|> read <$> many1 digit
