module EliudsEggs exposing (eggCount)


eggCount : Int -> Int
eggCount x =
    if x == 0 then
        0

    else if modBy x 2 == 0 then
        1 + eggCount (x // 10)

    else
        eggCount (x // 10)
