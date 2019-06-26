function concat(strings)
  outString = ""
  for _,v in ipairs(strings) do
    outString = outString .. v
  end
  return outString
end

print(concat({"Lua"," ","is"," ","fun","!"}))