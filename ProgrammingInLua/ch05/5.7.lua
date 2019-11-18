#!/usr/local/bin/lua -i
function transport(startList, startIndex, sectionLen, targetList, targetIndex)
  table.move(targetList, targetIndex, #targetList, targetIndex + sectionLen)
  table.move(startList, startIndex, startIndex + sectionLen - 1, targetIndex, targetList) 
end

function test ()
  original = {1,2,3,4,5,6,7,8,9,0}
  target = {1,2,3,4,5,6,7,8,9,0}

  print("Before Transport")
  for k,v in ipairs(target) do
    print(k,v)
  end


  print("\n\nAfter Transport")
  transport(original, 4, 3, target, 5)

  for k,v in ipairs(target) do
    print(k,v)
  end
end