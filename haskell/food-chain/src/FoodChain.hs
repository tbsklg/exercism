module FoodChain (song) where

import Text.Printf (printf)

data Verse = Verse {animal :: String, sentence :: String, animalsToSwallow :: [String]} deriving (Show, Eq)

song :: String
song = unlines . concatMap createVerse $ verses
  where
    createVerse :: Verse -> [String]
    createVerse (Verse {animal = "fly"}) = [iKnowAnOldLadyWhoSwallowedA "fly", perhapsSheWillDie, ""]
    createVerse (Verse {animal = "horse"}) = [iKnowAnOldLadyWhoSwallowedA "horse", dead]
    createVerse (Verse {animal = a, sentence = s, animalsToSwallow = as}) =
      [iKnowAnOldLadyWhoSwallowedA a, s] ++ swallow as ++ [perhapsSheWillDie, ""]

    perhapsSheWillDie :: String
    perhapsSheWillDie = "I don't know why she swallowed the fly. Perhaps she'll die."

    iKnowAnOldLadyWhoSwallowedA :: String -> String
    iKnowAnOldLadyWhoSwallowedA = printf "I know an old lady who swallowed a %s."

    sheSwallowedToCatch :: String -> String -> String
    sheSwallowedToCatch animalForCatch "spider" = sheSwallowedToCatch animalForCatch "spider that wriggled and jiggled and tickled inside her"
    sheSwallowedToCatch animalForCatch animalToCatch = printf "She swallowed the %s to catch the %s." animalForCatch animalToCatch

    dead :: String
    dead = "She's dead, of course!"

    swallow :: [String] -> [String]
    swallow animals = zipWith sheSwallowedToCatch animals . tail $ animals

    verses :: [Verse]
    verses =
      [ Verse {animal = "fly", sentence = "", animalsToSwallow = []},
        Verse {animal = "spider", sentence = "It wriggled and jiggled and tickled inside her.", animalsToSwallow = ["spider", "fly"]},
        Verse {animal = "bird", sentence = "How absurd to swallow a bird!", animalsToSwallow = ["bird", "spider", "fly"]},
        Verse {animal = "cat", sentence = "Imagine that, to swallow a cat!", animalsToSwallow = ["cat", "bird", "spider", "fly"]},
        Verse {animal = "dog", sentence = "What a hog, to swallow a dog!", animalsToSwallow = ["dog", "cat", "bird", "spider", "fly"]},
        Verse {animal = "goat", sentence = "Just opened her throat and swallowed a goat!", animalsToSwallow = ["goat", "dog", "cat", "bird", "spider", "fly"]},
        Verse {animal = "cow", sentence = "I don't know how she swallowed a cow!", animalsToSwallow = ["cow", "goat", "dog", "cat", "bird", "spider", "fly"]},
        Verse {animal = "horse", sentence = "She's dead, of course!", animalsToSwallow = []}
      ]
