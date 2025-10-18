module [is_leap_year]

is_leap_year = |year|
    if divisible_by year 400 then
        Bool.true
    else if divisible_by year 100 then
        Bool.false
    else
        divisible_by year 4

divisible_by = |x, y| x % y == 0
