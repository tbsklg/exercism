return {
	value = function(colors)
		local band = ""
		for i = 1, math.min(2, #colors) do
			local color = colors[i]
			if color == "black" then
				band = band .. "0"
			elseif color == "brown" then
				band = band .. "1"
			elseif color == "red" then
				band = band .. "2"
			elseif color == "orange" then
				band = band .. "3"
			elseif color == "yellow" then
				band = band .. "4"
			elseif color == "green" then
				band = band .. "5"
			elseif color == "blue" then
				band = band .. "6"
			elseif color == "violet" then
				band = band .. "7"
			elseif color == "grey" then
				band = band .. "8"
			elseif color == "white" then
				band = band .. "9"
			end
		end
		return tonumber(band)
	end,
}
