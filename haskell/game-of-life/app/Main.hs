import Control.Concurrent (threadDelay)
import GameOfLife (tick)

main :: IO ()
main = do
  let xs =
        [ [1, 1, 0, 1, 1, 0, 0, 0],
          [1, 0, 1, 1, 0, 0, 0, 0],
          [1, 1, 1, 0, 0, 1, 1, 1],
          [0, 0, 0, 0, 0, 1, 1, 0],
          [1, 0, 0, 0, 1, 1, 0, 0],
          [1, 1, 0, 0, 0, 1, 1, 1],
          [0, 0, 1, 0, 1, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 1, 1]
        ]
  runTick xs

runTick :: [[Int]] -> IO ()
runTick xs = do
  let ys = tick xs
  prettyPrint . printCells $ ys
  print separator
  threadDelay 500000
  runTick ys

printCells :: [[Int]] -> [String]
printCells = map (map printCell)

printCell :: Int -> Char
printCell 0 = ' '
printCell 1 = 'O'

separator :: String
separator = replicate 20 '-'

prettyPrint :: [String] -> IO ()
prettyPrint xs = do
  mapM_ print xs
