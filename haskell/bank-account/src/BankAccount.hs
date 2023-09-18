module BankAccount (
    BankAccount,
    closeAccount,
    getBalance,
    incrementBalance,
    openAccount,
) where

import Control.Concurrent.MVar

type BankAccount = MVar (Maybe Integer)

closeAccount :: BankAccount -> IO ()
closeAccount account = swapMVar account Nothing >> return ()

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance bankAccount = readMVar bankAccount

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance balance amount = modifyMVar balance $ \currentBalance ->
    case currentBalance of
        Nothing -> return (Nothing, Nothing)
        Just balance -> return (Just (balance + amount), Just (balance + amount))

openAccount :: IO BankAccount
openAccount = newMVar (Just 0)
