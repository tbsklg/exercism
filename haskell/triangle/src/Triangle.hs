module Triangle (TriangleType (..), triangleType) where

data TriangleType
        = Equilateral
        | Isosceles
        | Scalene
        | Illegal
        deriving (Eq, Show)

triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType
triangleType a b c
        | isValid && a == b && b == c = Equilateral
        | isValid && (a == b || a == c || b == c) = Isosceles
        | isValid && a /= b && b /= c && a /= c = Scalene
        | otherwise = Illegal
    where
        isValid = sum [a, b, c] > 0 && ((a + b) >= c && (a + c) >= b && (b + c) >= a)
