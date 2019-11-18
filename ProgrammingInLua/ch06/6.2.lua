#!/usr/local/bin/lua -i
function dropFirst(...)
  local array = table.pack(...)
  return table.unpack(array, 2, array.n)  
end

function test()
  print(dropFirst(1,2,3,4,5,nil,7))
end