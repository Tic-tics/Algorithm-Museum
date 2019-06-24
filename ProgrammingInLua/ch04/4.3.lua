function myInsert(original, position, sub)
  if position > 1 then
    return original:sub(1,position-1) .. sub .. original:sub(position,-1)
  elseif position >= #original then
    return original .. sub
  else return sub .. original end
end

print(myInsert("test",1,"pre"))
print(myInsert("test",3,"in"))
print(myInsert("test",6,"post"))