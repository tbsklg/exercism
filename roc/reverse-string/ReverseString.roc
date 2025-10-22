module [reverse]

import unicode.Grapheme

reverse : Str -> Str
reverse = \str ->
    when Grapheme.split str is
        Ok graphemes ->
            graphemes
            |> List.reverse
            |> Str.join_with ""
        
        Err _ ->
            str

# HINT: we have added the `unicode` package to the app's header in
#       reverse-string-test.roc, so you can use it here if you need to.
#       For example, you could use unicode.Grapheme, just sayin'.kkk
