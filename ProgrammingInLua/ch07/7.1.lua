#!/usr/local/bin/lua -i
function sortFile(inp, out)
  local inp = inp or nil --signify that it is optional
  local out = out or inp --only nil if both are nil
  
  --initialize input file
  if inp then
    inp = assert(io.open(inp, "r"))
  else
    inp = io.stdin
  end
  
  --read in the lines
  local lines = {}
  for line in inp:lines() do
    lines[#lines+1]=line
  end
  
  --sort all the lines
  table.sort(lines)
  
  --done with input
  inp:close()
  
  --open output stream
  if out then
    out = assert(io.open(out, "w"))
  else
    out = io.stdout
  end
  
  --output all the lines
  for _,v in pairs(lines) do
    out:write(v, "\n")
  end
  
  --close output stream
  out:close()
end

function test()
  --Instead of using the test function, I suggest you call sortFile directly

  --ZeroBrane is set with the algorithm museum as the project base.
  --Unfortunately, you may need to change this path for the demo to work, depending on your setup.
  sortFile(".\\ProgrammingInLua\\ch07\\7.1.in",".\\ProgrammingInLua\\ch07\\7.1.out")

  --This call is destructive to the test file
  --sortFile(".\\ProgrammingInLua\\ch07\\7.1.in")
end