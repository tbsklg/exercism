module CustomSet
  ( delete
  , difference
  , empty
  , fromList
  , insert
  , intersection
  , isDisjointFrom
  , isSubsetOf
  , member
  , null
  , size
  , toList
  , union
  ) where

import Prelude hiding (null)
import Data.List (nub, intersect, (\\))

newtype CustomSet a = CustomSet [a] deriving (Show)

instance Eq a => Eq (CustomSet a) where
  (CustomSet xs) == (CustomSet ys) = all (`elem` ys) xs && all (`elem` xs) ys

delete :: (Ord a, Eq a) => a -> CustomSet a -> CustomSet a
delete x set = CustomSet $ filter (/= x) $ toList set

difference :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
setA `difference` setB = CustomSet $ toList setA \\ toList setB

empty :: CustomSet a
empty = CustomSet []

fromList :: (Ord a, Eq a) => [a] -> CustomSet a
fromList xs = CustomSet $ nub xs

insert :: Eq a => a -> CustomSet a -> CustomSet a
insert x set = CustomSet $ nub $ x : toList set

intersection :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
setA `intersection` setB = CustomSet $ toList setA `intersect` toList setB

isDisjointFrom :: Eq a => CustomSet a -> CustomSet a -> Bool
setA `isDisjointFrom` setB = null . intersection setA $ setB

isSubsetOf :: Eq a => CustomSet a -> CustomSet a -> Bool
setA `isSubsetOf` setB = all (`member` setB) . toList $ setA

member :: Eq a => a -> CustomSet a -> Bool
member x (CustomSet l) = x `elem` l

null :: Eq a => CustomSet a -> Bool
null (CustomSet l) = length l == 0

size :: CustomSet a -> Int
size (CustomSet l) = length l

toList :: CustomSet a -> [a]
toList (CustomSet l) = l

union :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
setA `union` setB = CustomSet $ nub $ toList setA ++ toList setB
