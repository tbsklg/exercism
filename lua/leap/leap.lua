local function divisible_by(n)
  return function(x)
    return x % n == 0
  end
end

local function complement(f)
  return function(x)
    return not f(x)
  end
end

local function and_then(f, g)
  return function(x)
    return f(x) and g(x)
  end
end

local function or_else(f, g)
  return function(x)
    return f(x) or g(x)
  end
end

local divisible_by_4   = divisible_by(4)
local divisible_by_100 = divisible_by(100)
local divisible_by_400 = divisible_by(400)

local rule1 = and_then(divisible_by_4, complement(divisible_by_100))

local rule2 = divisible_by_400

local leap_year = or_else(rule1, rule2)

return leap_year
