local divisible_by = function(x, y)
  return x % y == 0
end

local divisible_by_four = function(number)
  return divisible_by(number, 4)
end

local divisible_by_hundret = function(number)
  return divisible_by(number, 100)
end

local divisible_by_four_hundert = function(number)
  return divisible_by(number, 400)
end

local leap_year = function(number)
  return divisible_by_four(number) and not divisible_by_hundret(number) or divisible_by_hundret(number) and divisible_by_four_hundert(number)
end

return leap_year
