#!/usr/local/bin/lua -i
function validSequence(seq)
  local seqIndex = {}
  for k,_ in ipairs(seq) do
    seqIndex[k] = true
  end
  for k,_ in pairs(seq) do
    if not seqIndex[k] then return false end
  end
  return true
end

function test()
  print(validSequence({1,2,3,4,5,6,7}))
  print(validSequence({1,2,3,4,[100]=true}))
end