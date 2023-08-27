module Poker (bestHands) where

import Text.Parsec (digit, many1, oneOf, parse, sepBy, space, string, (<|>))

data Rank = Rank {rankType :: RankType, rankValue :: String} deriving (Eq, Ord, Show)
data RankType = Number | Jack | Queen | King | Ace deriving (Eq, Ord, Show)
data Card = Card {rank :: Rank, suit :: Suite} deriving (Eq, Ord, Show)
data Suite = Hearts | Diamonds | Clubs | Spades deriving (Eq, Ord, Show)
data Hand = Hand {cards :: [Card], handType :: HandType} deriving (Eq, Ord, Show)
data HandType = HighCard | OnePair | TwoPair | ThreeOfAKind | Straight | Flush | FullHouse | FourOfAKind | StraightFlush deriving (Eq, Ord, Show)

bestHands :: [String] -> Maybe [String]
bestHands [x] = Just [x]
bestHands xs = Just . head . sortOn bestHand . map hand $ map parseCards xs

bestHand :: Hand -> Hand -> Ordering
bestHand (Hand cardsA HighCard) (Hand cardsB HighCard) = compare (highCard cardsA) (highCard cardsB)

hand :: [Card] -> Hand
hand cards = Hand cards winningHandType
  where
    winningHandType
        -- \| isStraightFlush cards = StraightFlush
        -- \| isFourOfAKind cards = FourOfAKind
        -- \| isFullHouse cards = FullHouse
        -- \| isFlush cards = Flush
        -- \| isStraight cards = Straight
        -- \| isThreeOfAKind cards = ThreeOfAKind
        -- \| isTwoPair cards = TwoPair
        -- \| isOnePair cards = OnePair
        | otherwise = HighCard

-- >>> 1 == 2

highCard :: [Card] -> Card
highCard cards = maximum cards

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
