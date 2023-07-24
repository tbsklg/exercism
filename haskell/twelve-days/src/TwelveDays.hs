module TwelveDays (recite) where

import Data.List (intercalate)
import qualified Data.Vector as V
import Text.Printf (printf)

recite :: Int -> Int -> [String]
recite start stop = [(\day -> printf "On the %s day of Christmas my true love gave to me: %s" (nth day) (generateGifts day)) x | x <- [start .. stop]]
  where
    generateGifts 1 = V.head gifts ++ "."
    generateGifts n = (intercalate ", " . V.toList . V.reverse . V.slice 1 (n - 1) $ gifts) ++ ", and " ++ generateGifts 1

nth :: Int -> String
nth 1 = "first"
nth 2 = "second"
nth 3 = "third"
nth 4 = "fourth"
nth 5 = "fifth"
nth 6 = "sixth"
nth 7 = "seventh"
nth 8 = "eighth"
nth 9 = "ninth"
nth 10 = "tenth"
nth 11 = "eleventh"
nth 12 = "twelfth"
nth _ = error "Not implemented"

gifts :: V.Vector String
gifts =
  V.fromList
    [ "a Partridge in a Pear Tree",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying",
      "seven Swans-a-Swimming",
      "eight Maids-a-Milking",
      "nine Ladies Dancing",
      "ten Lords-a-Leaping",
      "eleven Pipers Piping",
      "twelve Drummers Drumming"
    ]
