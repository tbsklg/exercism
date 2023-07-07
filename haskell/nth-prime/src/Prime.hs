module Prime (nth) where

nth :: Int -> Maybe Integer
nth 0 = Nothing
nth n = Just $ primes !! (n - 1)
 where
    primes = sieve [2..]
    sieve (x:xs) = x : sieve [y | y <- xs, y `mod` x /= 0]
    