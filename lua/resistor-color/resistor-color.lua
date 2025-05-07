return {
  color_code = function(color)
    local color_map = {
      black = 0,
      brown = 1,
      red = 2,
      orange = 3,
      yellow = 4,
      green = 5,
      blue = 6,
      violet = 7,
      grey = 8,
      white = 9
    }
    local normalized_color = color and string.lower(color) or nil
    return color_map[normalized_color]
  end
}
