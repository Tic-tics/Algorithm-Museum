function dropFirst(...)
  array = table.pack(...)
  return table.unpack(array, 2, array.n)  
end

print(dropFirst(1,2,3,4,5,nil,7))