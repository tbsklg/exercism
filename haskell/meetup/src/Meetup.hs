module Meetup (Weekday (..), Schedule (..), meetupDay) where

import Data.Time.Calendar (Day, dayOfWeek, fromGregorian)

data Weekday
        = Monday
        | Tuesday
        | Wednesday
        | Thursday
        | Friday
        | Saturday
        | Sunday

data Schedule
        = First
        | Second
        | Third
        | Fourth
        | Last
        | Teenth

type Year = Integer
type Month = Int

meetupDay :: Schedule -> Weekday -> Integer -> Int -> Day
meetupDay First Monday year month = fromGregorian year month $ mondays year month !! 0
meetupDay First Tuesday year month = fromGregorian year month $ (tuesdays year month) !! 0
meetupDay First Wednesday year month = fromGregorian year month $ (wednesdays year month) !! 0
meetupDay First Thursday year month = fromGregorian year month $ (thursdays year month) !! 0
meetupDay First Friday year month = fromGregorian year month $ (fridays year month) !! 0
meetupDay First Saturday year month = fromGregorian year month $ (saturdays year month) !! 0
meetupDay First Sunday year month = fromGregorian year month $ (sundays year month) !! 0
meetupDay Second Monday year month = fromGregorian year month $ mondays year month !! 1
meetupDay Second Tuesday year month = fromGregorian year month $ tuesdays year month !! 1
meetupDay Second Wednesday year month = fromGregorian year month $ wednesdays year month !! 1
meetupDay Second Thursday year month = fromGregorian year month $ thursdays year month !! 1
meetupDay Second Friday year month = fromGregorian year month $ fridays year month !! 1
meetupDay Second Saturday year month = fromGregorian year month $ saturdays year month !! 1
meetupDay Second Sunday year month = fromGregorian year month $ sundays year month !! 1
meetupDay Third Monday year month = fromGregorian year month $ mondays year month !! 2
meetupDay Third Tuesday year month = fromGregorian year month $ tuesdays year month !! 2
meetupDay Third Wednesday year month = fromGregorian year month $ wednesdays year month !! 2
meetupDay Third Thursday year month = fromGregorian year month $ thursdays year month !! 2
meetupDay Third Friday year month = fromGregorian year month $ fridays year month !! 2
meetupDay Third Saturday year month = fromGregorian year month $ saturdays year month !! 2
meetupDay Third Sunday year month = fromGregorian year month $ sundays year month !! 2
meetupDay Fourth Monday year month = fromGregorian year month $ mondays year month !! 3
meetupDay Fourth Tuesday year month = fromGregorian year month $ tuesdays year month !! 3
meetupDay Fourth Wednesday year month = fromGregorian year month $ wednesdays year month !! 3
meetupDay Fourth Thursday year month = fromGregorian year month $ thursdays year month !! 3
meetupDay Fourth Friday year month = fromGregorian year month $ fridays year month !! 3
meetupDay Fourth Saturday year month = fromGregorian year month $ saturdays year month !! 3
meetupDay Fourth Sunday year month = fromGregorian year month $ sundays year month !! 3
meetupDay Last Monday year month = fromGregorian year month $ last $ mondays year month
meetupDay Last Tuesday year month = fromGregorian year month $ last $ tuesdays year month
meetupDay Last Wednesday year month = fromGregorian year month $ last $ wednesdays year month
meetupDay Last Thursday year month = fromGregorian year month $ last $ thursdays year month
meetupDay Last Friday year month = fromGregorian year month $ last $ fridays year month
meetupDay Last Saturday year month = fromGregorian year month $ last $ saturdays year month
meetupDay Last Sunday year month = fromGregorian year month $ last $ sundays year month
meetupDay Teenth Monday year month = fromGregorian year month $ filter (isMonday year month) [13 .. 19] !! 0
meetupDay Teenth Tuesday year month = fromGregorian year month $ filter (isTuesday year month) [13 .. 19] !! 0
meetupDay Teenth Wednesday year month = fromGregorian year month $ filter (isWednesday year month) [13 .. 19] !! 0
meetupDay Teenth Thursday year month = fromGregorian year month $ filter (isThursday year month) [13 .. 19] !! 0
meetupDay Teenth Friday year month = fromGregorian year month $ filter (isFriday year month) [13 .. 19] !! 0
meetupDay Teenth Saturday year month = fromGregorian year month $ filter (isSaturday year month) [13 .. 19] !! 0
meetupDay Teenth Sunday year month = fromGregorian year month $ filter (isSunday year month) [13 .. 19] !! 0

mondays :: Year -> Month -> [Int]
mondays year month = filter (isMonday year month) [1 .. 31]

tuesdays :: Year -> Month -> [Int]
tuesdays year month = filter (isTuesday year month) [1 .. 31]

wednesdays :: Year -> Month -> [Int]
wednesdays year month = filter (isWednesday year month) [1 .. 31]

thursdays :: Year -> Month -> [Int]
thursdays year month = filter (isThursday year month) [1 .. 31]

fridays :: Year -> Month -> [Int]
fridays year month = filter (isFriday year month) [1 .. 31]

saturdays :: Year -> Month -> [Int]
saturdays year month = filter (isSaturday year month) [1 .. 31]

sundays :: Year -> Month -> [Int]
sundays year month = filter (isSunday year month) [1 .. 31]

isMonday :: Integer -> Int -> Int -> Bool
isMonday year month = (==) 1 . fromEnum . dayOfWeek . fromGregorian year month

isTuesday :: Integer -> Int -> Int -> Bool
isTuesday year month = (==) 2 . fromEnum . dayOfWeek . fromGregorian year month

isWednesday :: Integer -> Int -> Int -> Bool
isWednesday year month = (==) 3 . fromEnum . dayOfWeek . fromGregorian year month

isThursday :: Integer -> Int -> Int -> Bool
isThursday year month = (==) 4 . fromEnum . dayOfWeek . fromGregorian year month

isFriday :: Integer -> Int -> Int -> Bool
isFriday year month = (==) 5 . fromEnum . dayOfWeek . fromGregorian year month

isSaturday :: Integer -> Int -> Int -> Bool
isSaturday year month = (==) 6 . fromEnum . dayOfWeek . fromGregorian year month

isSunday :: Integer -> Int -> Int -> Bool
isSunday year month = (==) 7 . fromEnum . dayOfWeek . fromGregorian year month
