module Deque (Deque, mkDeque, pop, push, shift, unshift) where

import Data.IORef

type Node a = [a]
type Deque a = IORef (Node a)

mkDeque :: IO (Deque a)
mkDeque = newIORef []

pop :: Deque a -> IO (Maybe a)
pop d = do
  deque <- readIORef d
  case deque of
    [] -> return Nothing
    (x : xs) -> do
      writeIORef d xs
      return $ Just x

push :: Deque a -> a -> IO ()
push deque x = do
  xs <- readIORef deque
  writeIORef deque (x : xs)

unshift :: Deque a -> a -> IO ()
unshift deque x = do
  xs <- readIORef deque
  writeIORef deque (xs ++ [x])

shift :: Deque a -> IO (Maybe a)
shift deque = do
  xs <- readIORef deque
  case xs of
    [] -> return Nothing
    ys -> do
      writeIORef deque (init ys)
      return $ Just $ last ys
