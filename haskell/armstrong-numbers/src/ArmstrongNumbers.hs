module ArmstrongNumbers (armstrong) where

armstrong :: Integral a => a -> Bool
armstrong i = (==) i . sum . map (\x -> x ^ length digits) $ digits
  where
    digits = getDigits i

    getDigits :: Integral a => a -> [a]
    getDigits 0 = []
    getDigits x = (x `mod` 10) : getDigits (x `div` 10)

