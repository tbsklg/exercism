module Base (Error (..), rebase) where

data Error a = InvalidInputBase | InvalidOutputBase | InvalidDigit a
    deriving (Show, Eq)

rebase :: Integral a => a -> a -> [a] -> Either (Error a) [a]
rebase inputBase outputBase inputDigits
    | inputBase < 2 = Left InvalidInputBase
    | outputBase < 2 = Left InvalidOutputBase
    | any (< 0) inputDigits = Left (InvalidDigit . head . filter (< 0) $ inputDigits)
    | any (> (inputBase - 1)) inputDigits = Left (InvalidDigit . head . filter (> (inputBase - 1)) $ inputDigits)
    | otherwise = Right (toBase outputBase . toBase10 inputBase $ inputDigits)

toBase :: Integral a => a -> a -> [a]
toBase _ 0 = []
toBase base number = toBase base (number `div` base) ++ [number `mod` base]

toBase10 :: Num b => b -> [b] -> b
toBase10 base digits = foldr (\(x, z) y -> y + x * (base ^ (z :: Integer))) 0 $ zip (reverse digits) [0 ..]
