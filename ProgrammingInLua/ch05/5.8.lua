#!/usr/local/bin/lua -i
function concat(strings)
  local outString = ""
  for _,v in ipairs(strings) do
    outString = outString .. v
  end
  return outString
end

function test()
  print(concat({"Lua"," ","is"," ","fun","!"}))
end