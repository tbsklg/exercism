return function(n)
  local rain = ''

  if n % 3 == 0 then rain = rain..'Pling' end
  if n % 5 == 0 then rain = rain..'Plang' end
  if n % 7 == 0 then rain = rain..'Plong' end

  if rain == '' then return n..'' else return rain end
end
