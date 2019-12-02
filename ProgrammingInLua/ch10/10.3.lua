#!/usr/local/bin/lua -i
lpeg = require "lpeg"
-- I've chosen to use the lpeg library for these string recognition exercises
-- My main reason is that I think it is cooler and also more readable than regex BS
-- If you want regex style solutions, open a pull request(with the solutions).

-- This function takes in a conversion_table and returns a function that transliterates accordingly
function transliterator(conversion_table)
    -- We start with a nil capture
    local capture = nil
    for consume,replace in pairs(conversion_table) do
        -- This converts false to removals
        replace = replace or ""

        -- The pattern to replace a character
        local new_conversion = lpeg.P(consume) * lpeg.Cc(replace)

        -- Either initializes the capture, or adds on another possibility
        if not capture then
            capture = new_conversion
        else
            capture = capture + new_conversion
        end
    end

    -- Makes the capture skip over characters not specified in the conversion_table as a last resort (ordered choice)
    capture = capture + lpeg.C(lpeg.P(1))

    -- Strings all the captures together with the ^0 and then appends them together with the lambda wrapper for ..
    capture = lpeg.Cf(capture^0, function (left,right) return left .. right end)

    -- Returns a closure that calls match with the appropriate object and returns the result
    return function (string) return capture:match(string) end
end

-- A simple function to fulfill the exercise.
-- Notice that it returns the result of calling the return value of transliterator against the target_string
function transliterate(target_string, conversion_table)
    return transliterator(conversion_table)(target_string)
end

function test()
    -- Create a simple single shift cypher table
    local conversion_table = {["z"] = "a", ["Z"] = "A"}
    for i=0, 24 do
        conversion_table[string.char(97+i)] = string.char(97+i+1)
        conversion_table[string.char(65+i)] = string.char(65+i+1)
    end

    print("HELLO WORLD! ==> " .. transliterate("HELLO WORLD", conversion_table))

    -- Here we demonstrate that we can use the transliterator function to create a reusable transliterator
    local shift = transliterator(conversion_table)
    conversion_table[" "] = false
    local remove_spaces_shift = transliterator(conversion_table)

    print("shift('HELLO WORLD!') ==> " .. shift("HELLO WORLD!"))
    print("remove_spaces_shift('HELLO WORLD!') ==> " .. remove_spaces_shift("HELLO WORLD!"))
end
