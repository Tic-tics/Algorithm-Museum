#!/usr/local/bin/lua -i
function printCombos(deck, prefix, first)
  local prefix = prefix or ""
  local first = first or 1
  
  if first > #deck then print(prefix) return end
  printCombos(deck, prefix .. deck[first], first+1)
  printCombos(deck, prefix, first+1)
end

function test()
  printCombos({1,2,3,4})
end