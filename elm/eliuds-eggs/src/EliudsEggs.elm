module EliudsEggs exposing (eggCount)


eggCount : Int -> Int
eggCount x =
    case x of
        0 ->
            0

        1 ->
            1

        _ ->
            modBy 2 x + eggCount (x // 2)
