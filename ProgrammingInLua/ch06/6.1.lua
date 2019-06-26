function arrayPrinter(array)
  for _,v in ipairs(array) do
    print(v)
  end
end

arrayPrinter({1,2,3,4,5})