#!/usr/local/bin/lua -i
function dropLast(...)
  local array = table.pack(...)
  return table.unpack(array, 1, array.n-1)  
end

function test()
  print(dropLast(1,2,3,4,5,nil,7))
end