module Poker (bestHands) where

import Data.Function (on)
import Data.List (group, maximumBy, sort, sortBy)
import Data.Ord (comparing)
import Text.Parsec (digit, many1, oneOf, parse, sepBy, space, string, (<|>))

data Rank = Rank {rankType :: RankType, rankValue :: String} deriving (Eq, Show)
data RankType = Number | Jack | Queen | King | Ace deriving (Eq, Ord, Show)
data Card = Card {rank :: Rank, suite :: Suite} deriving (Eq, Show)
data Suite = Hearts | Diamonds | Clubs | Spades deriving (Eq, Ord, Show)
data Hand = Hand {cards :: [Card]} deriving (Eq, Ord, Show)
data HandType
    = HighCard [Card]
    | OnePair Rank
    | TwoPair Rank Rank Rank
    | ThreeOfAKind Rank
    | Straight Rank
    | Flush [Card]
    | FullHouse Rank Rank
    | FourOfAKind Rank
    | StraightFlush Rank
    deriving (Eq, Ord, Show)

instance Ord Card where
    compare (Card (Rank rt1 rv1) _) (Card (Rank rt2 rv2) _) = compare rt1 rt2 <> compare rv1 rv2

instance Enum Rank where
    toEnum :: Int -> Rank
    toEnum 2 = Rank Number "2"
    toEnum 3 = Rank Number "3"
    toEnum 4 = Rank Number "4"
    toEnum 5 = Rank Number "5"
    toEnum 6 = Rank Number "6"
    toEnum 7 = Rank Number "7"
    toEnum 8 = Rank Number "8"
    toEnum 9 = Rank Number "9"
    toEnum 10 = Rank Number "10"
    toEnum 11 = Rank Jack "J"
    toEnum 12 = Rank Queen "Q"
    toEnum 13 = Rank King "K"
    toEnum 14 = Rank Ace "A"
    toEnum _ = error "Invalid rank"

    fromEnum :: Rank -> Int
    fromEnum (Rank Number "2") = 2
    fromEnum (Rank Number "3") = 3
    fromEnum (Rank Number "4") = 4
    fromEnum (Rank Number "5") = 5
    fromEnum (Rank Number "6") = 6
    fromEnum (Rank Number "7") = 7
    fromEnum (Rank Number "8") = 8
    fromEnum (Rank Number "9") = 9
    fromEnum (Rank Number "10") = 10
    fromEnum (Rank Jack "J") = 11
    fromEnum (Rank Queen "Q") = 12
    fromEnum (Rank King "K") = 13
    fromEnum (Rank Ace "A") = 14
    fromEnum _ = error "Invalid rank"

instance Ord Rank where
    compare = compare `on` fromEnum

bestHands :: [String] -> Maybe [String]
bestHands xs = case mapM parseCards xs of
    Nothing -> Nothing
    Just hands -> Just $ map printHand $ winningHands hands

winningHands :: [Hand] -> [Hand]
winningHands hands = filter (\hand -> compare (cards hand) (cards winner) == EQ) hands
  where
    winner :: Hand
    winner = maximumBy (comparing $ handType . cards) hands

handType :: [Card] -> HandType
handType cards
    | straightHi && flush = StraightFlush (last sortedRanks)
    | straightLo && flush = StraightFlush (Rank Number "5")
    | flush = Flush sortedCards
    | straightHi = Straight (last sortedRanks)
    | straightLo = Straight (Rank Number "5")
    | otherwise = case reverse . sortBy (compare `on` length) . group $ sortedRanks of
        [[c1, _, _, _], [_]] -> FourOfAKind c1
        [[c2, _, _], [c1, _]] -> FullHouse c2 c1
        [[c1, _, _], [_], [_]] -> ThreeOfAKind c1
        [[c1, _], [c2, _], [k]] -> TwoPair c1 c2 k
        [[c1, _], [_], [_], [_]] -> OnePair c1
        _ -> HighCard (sortBy (compare `on` rank) $ cards)
  where
    sortedCards :: [Card]
    sortedCards = sortBy (compare `on` rank) cards

    sortedRanks :: [Rank]
    sortedRanks = sort . map rank $ cards

    straightHi :: Bool
    straightHi = [head sortedRanks .. last sortedRanks] == sortedRanks

    straightLo :: Bool
    straightLo = [Rank Number "2", Rank Number "3", Rank Number "4", Rank Number "5", Rank Ace "A"] == sortedRanks

    flush :: Bool
    flush = length (group $ map suite cards) == 1

printHand :: Hand -> String
printHand Hand{cards = c} = printCards c

printCards :: [Card] -> String
printCards = unwords . map printCard

printCard :: Card -> String
printCard Card{rank = r, suite = s} = printRank r ++ [printSuit s]

printRank :: Rank -> String
printRank = rankValue

printSuit :: Suite -> Char
printSuit Hearts = 'H'
printSuit Diamonds = 'D'
printSuit Clubs = 'C'
printSuit Spades = 'S'

parseCards :: String -> Maybe Hand
parseCards xs = case parse cardsParser "" xs of
    Left _ -> Nothing
    Right cards -> Just cards
  where
    cardsParser = do
        cards <- sepBy cardParser (space)
        return Hand{cards = cards}

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
    parseSuite _ = error "Invalid suite"
