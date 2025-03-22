module BettysBikeShop exposing (penceToPounds, poundsToString)

import String as S

penceToPounds : Int -> Float
penceToPounds pence = toFloat pence / 100

poundsToString : Float -> String
poundsToString pounds = "£" ++ S.fromFloat pounds
