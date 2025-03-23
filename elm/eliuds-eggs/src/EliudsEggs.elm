module EliudsEggs exposing (eggCount)


eggCount : Int -> Int
eggCount x =
    case x of
        0 ->
            0

        _ ->
            let
                lastBit =
                    modBy 2 x

                remainingBits =
                    x // 2
            in
            case lastBit of
                1 ->
                    1 + eggCount remainingBits

                _ ->
                    eggCount remainingBits
