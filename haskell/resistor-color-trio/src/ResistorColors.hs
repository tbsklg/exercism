module ResistorColors (Color(..), Resistor(..), label, ohms) where
import Text.Printf (printf)

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

label :: Resistor -> String
label = display . ohms
  where
    display :: Int -> String
    display o
      | o < 1000  = printf "%d ohms" o
      | o < 1000000  = printf "%d kiloohms" (o `div` 1000)
      | o < 1000000000  = printf "%d megaohms" (o `div` 1000000)
      | otherwise = printf "%d gigaohms" (o `div` 1000000000)

ohms :: Resistor -> Int
ohms Resistor {bands = (x, y, z)} = (fromEnum x * 10 + fromEnum y) * 10 ^ fromEnum z
