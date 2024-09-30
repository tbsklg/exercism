module Satellite (treeFromTraversals) where

import BinaryTree (BinaryTree (..))
import Data.List (sort)

treeFromTraversals :: (Show a, Ord a) => [a] -> [a] -> Maybe (BinaryTree a)
treeFromTraversals [] [] = Nothing
treeFromTraversals preorder inorder
  | hasDuplicates preorder || hasDuplicates inorder = Nothing
  | sort preorder /= sort inorder = Nothing
  | otherwise = go preorder inorder
  where
    go :: (Show a, Ord a) => [a] -> [a] -> Maybe (BinaryTree a)
    go [] [] = Just Leaf
    go po io =
      let x = head po
          leftTree =
            let po' = filter (`elem` io') po
                io' = takeWhile (/= x) io
             in go po' io'
          rightTree =
            let po' = filter (`elem` io') po
                io' = tail $ dropWhile (/= x) io
             in go po' io'
       in Branch <$> leftTree <*> pure x <*> rightTree

hasDuplicates :: (Eq a) => [a] -> Bool
hasDuplicates [] = False
hasDuplicates (x : xs) = x `elem` xs || hasDuplicates xs
