module DND
  ( Character (..),
    ability,
    modifier,
    character,
  )
where

import Test.QuickCheck (Arbitrary (arbitrary), Gen, choose)

data Character = Character
  { strength :: Int,
    dexterity :: Int,
    constitution :: Int,
    intelligence :: Int,
    wisdom :: Int,
    charisma :: Int,
    hitpoints :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier x = (x - 10) `div` 2

ability :: Gen Int
ability = choose (3, 18)

character :: Gen Character
character = arbitrary

instance Arbitrary Character where
  arbitrary = do
    strength' <- ability
    dexterity' <- ability
    constitution' <- ability
    intelligence' <- ability
    wisdom' <- ability
    charisma' <- ability
    return
      Character
        { strength = strength',
          dexterity = dexterity',
          constitution = constitution',
          intelligence = intelligence',
          wisdom = wisdom',
          charisma = charisma',
          hitpoints = 10 + modifier constitution'
        }