module School (School, add, empty, grade, sorted) where

import Data.List (sort)
import Data.Maybe (fromMaybe)

type Grade = Int
type Student = String
type School = [(Grade, [Student])]

add :: Int -> String -> School -> School
add gradeNum student school = case lookup gradeNum school of
  Nothing -> (gradeNum, [student]) : school
  Just students -> (gradeNum, sort (student : students)) : [(g, s) | (g, s) <- school, gradeNum /= g]

empty :: School
empty = []

grade :: Int -> School -> [String]
grade gradeNum school = fromMaybe [] (lookup gradeNum school)

sorted :: School -> [(Int, [String])]
sorted = sort
