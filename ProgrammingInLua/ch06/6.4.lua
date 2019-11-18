#!/usr/local/bin/lua -i
math.randomseed(os.time())
function shuffle(deck)
  for i = #deck, 2, -1 do
    local card = math.random(i)
    deck[i], deck[card] = deck[card], deck[i]
  end
  return deck
end

function test()
  print(table.unpack(shuffle({1,2,3,4,5})))
end