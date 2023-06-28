module SpaceAge (Planet (..), ageOn) where

data Planet
            = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn Mercury = toEarthYears 0.2408467 
ageOn Venus = toEarthYears 0.61519726 
ageOn Earth = toEarthYears 1.0 
ageOn Mars = toEarthYears 1.8808158 
ageOn Jupiter = toEarthYears 11.862615 
ageOn Saturn = toEarthYears 29.447498 
ageOn Uranus = toEarthYears 84.016846 
ageOn Neptune = toEarthYears 164.79132 

toEarthYears :: Float -> Float -> Float
toEarthYears factor seconds = seconds / 3600 / 24 / (365.25 * factor)
