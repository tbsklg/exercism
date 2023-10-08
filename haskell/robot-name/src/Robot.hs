module Robot (Robot, initialState, mkRobot, resetName, robotName) where

import Control.Monad.State (StateT, get, liftIO, put)
import Data.IORef (IORef, newIORef, readIORef, writeIORef)
import System.Random (getStdGen, newStdGen, randomRs)

newtype Robot = Robot (IORef String)
type NameCache = [String]

initialState :: NameCache
initialState = []

mkRobot :: StateT NameCache IO Robot
mkRobot = do
  name <- liftIO generateRandomName
  names <- get
  if name `elem` names
    then mkRobot
    else do
      put (name : names)
      liftIO (Robot <$> newIORef name)

generateRandomName :: IO String
generateRandomName = do
  g <- liftIO newStdGen
  let s = take 2 (randomRs ('A', 'Z') g)
  let n = take 3 (randomRs ('0', '9') g)
  return $ s ++ n

resetName :: Robot -> StateT NameCache IO ()
resetName (Robot nameRef) = do
  new <- liftIO generateRandomName
  names <- get
  if new `elem` names
    then resetName (Robot nameRef)
    else do
      liftIO $ writeIORef nameRef new

robotName :: Robot -> IO String
robotName (Robot nameRef) = readIORef nameRef
