#!/usr/local/bin/lua -i
function removeSub(original, start, len)
  if start < 1 then start = 1 end
  if start + len > #original then len = #original - start end
  return original:sub(1,start-1) .. original:sub(start+len,-1)
end

function test()
  print(removeSub("Hello World", 1, 0))
  print(removeSub("Hello World", 3, 2))
  print(removeSub("Hello World", 7, 4))
  print(removeSub("Hello World", 5, 1))
end