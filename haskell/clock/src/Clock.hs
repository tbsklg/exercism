module Clock (addDelta, fromHourMin, toString) where

import Text.Printf (printf)

type Hour = Int

type Min = Int

data Clock = Clock Hour Min deriving (Eq)

instance Show Clock where
  show (Clock 24 0) = "00:00"
  show (Clock hour min) = printf "%02d:%02d" hour min

fromHourMin :: Hour -> Min -> Clock
fromHourMin hour min = Clock hour' min'
  where
    hour' = (hour * 60 + min) `div` 60 `mod` 24
    min' = (hour * 60 + min) `mod` 60

toString :: Clock -> String
toString = show

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min (Clock hour' min') = fromHourMin (hour + hour') (min + min')
