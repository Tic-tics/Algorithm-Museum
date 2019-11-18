#!/usr/local/bin/lua -i
--defines a factorial function
function fact(n)
	if n <= 0 then
		return 1
	else
		return n * fact(n-1)
	end
end

function test()
	print("enter a number:")
	a = io.read("*n")
	print(fact(a))
end