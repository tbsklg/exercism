module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA = traverse complement

complement :: Char -> Either Char Char
complement 'C' = Right 'G'
complement 'G' = Right 'C'
complement 'T' = Right 'A'
complement 'A' = Right 'U'
complement x = Left x
