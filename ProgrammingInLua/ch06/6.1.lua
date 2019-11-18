#!/usr/local/bin/lua -i
function arrayPrinter(array)
  for _,v in ipairs(array) do
    print(v)
  end
end

function test()
  arrayPrinter({1,2,3,4,5})
end