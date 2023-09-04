{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}

module Person (
  Address (..),
  Born (..),
  Name (..),
  Person (..),
  bornStreet,
  renameStreets,
  setBirthMonth,
  setCurrentStreet,
) where

import Control.Lens
import Data.Time.Calendar (Day, fromGregorian, toGregorian)

data Address = Address
  { _street :: String
  , _houseNumber :: Int
  , _place :: String
  , _country :: String
  }
makeLenses ''Address

data Born = Born
  { _bornAt :: Address
  , _bornOn :: Day
  }
makeLenses ''Born

data Name = Name
  { _foreNames :: String
  , _surName :: String
  }
makeLenses ''Name

data Person = Person
  { _name :: Name
  , _born :: Born
  , _address :: Address
  }
makeLenses ''Person

bornStreet :: Born -> String
bornStreet = view (bornAt . street)

setCurrentStreet :: String -> Person -> Person
setCurrentStreet = set (address . street)

setBirthMonth :: Int -> Person -> Person
setBirthMonth month _person = set (born . bornOn) newDate _person
 where
  (year, _, day) = toGregorian $ _person ^. born . bornOn
  newDate = fromGregorian year month day

renameStreets :: (String -> String) -> Person -> Person
renameStreets f = over (address . street) f . over (born . bornAt . street) f
