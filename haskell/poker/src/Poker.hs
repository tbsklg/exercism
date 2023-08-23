module Poker (bestHands) where

import Text.Parsec (digit, many1, oneOf, parse, sepBy, space, string, (<|>))

data Rank = Rank {rankType :: RankType, rankValue :: String} deriving (Eq, Ord, Show)
data RankType = Number | Jack | Queen | King | Ace deriving (Eq, Ord, Show)
data Card = Card {rank :: Rank, suit :: Suite} deriving (Eq, Ord, Show)
data Suite = Hearts | Diamonds | Clubs | Spades deriving (Eq, Ord, Show)
data Hand = Hand {cards :: [Card], handType :: HandType} deriving (Eq, Ord, Show)
data HandType = HighCard | OnePair | TwoPair | ThreeOfAKind | Straight | Flush | FullHouse | FourOfAKind | StraightFlush deriving (Eq, Ord, Show)

bestHands :: [String] -> Maybe [String]
bestHands xs = Just xs

hand :: [Card] -> Hand
hand cards = Hand cards winningHandType
  where
    winningHandType
        | isStraightFlush cards = StraightFlush
        | isFourOfAKind cards = FourOfAKind
        | isFullHouse cards = FullHouse
        | isFlush cards = Flush
        | isStraight cards = Straight
        | isThreeOfAKind cards = ThreeOfAKind
        | isTwoPair cards = TwoPair
        | isOnePair cards = OnePair
        | otherwise = HighCard

isStraightFlush :: [Card] -> Bool
isStraightFlush cards = isStraight cards && isFlush cards

isStraight :: [Card] -> Bool
isStraight cards = isConsecutive $ map rank cards

isConsecutive :: [Rank] -> Bool
isConsecutive xs = xs == [minimum xs .. maximum xs]

parseCards :: String -> [Card]
parseCards xs = case parse cardsParser "" xs of
    Left err -> error $ show err
    Right cards -> cards
  where
    cardsParser = do
        cards <- sepBy cardParser (space)
        return cards

    cardParser = do
        rank <- many1 digit <|> string "J" <|> string "Q" <|> string "K" <|> string "A"
        suit <- oneOf "HDSC"
        return $ Card (Rank (parseRankType rank) rank) (parseSuite suit)

    parseRankType :: String -> RankType
    parseRankType "J" = Jack
    parseRankType "Q" = Queen
    parseRankType "K" = King
    parseRankType "A" = Ace
    parseRankType _ = Number

    parseSuite :: Char -> Suite
    parseSuite 'H' = Hearts
    parseSuite 'D' = Diamonds
    parseSuite 'S' = Spades
    parseSuite 'C' = Clubs
