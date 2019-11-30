#!/usr/local/bin/lua -i
lpeg = require "lpeg"
-- I've chosen to use the lpeg library for these string recognition exercises
-- My main reason is that I think it is cooler and also more readable than regex BS
-- If you want regex style solutions, open a pull request(with the solutions).

function split(target, deliminator)
    assert(type(target) == 'string')
    assert(type(deliminator) == 'string')

    delim = lpeg.P(deliminator)
    token = (lpeg.P(1) - delim)^0
    cList = lpeg.Ct(lpeg.C(token) * (delim * lpeg.C(token))^0)

    return cList:match(target)
end

function test()
    tests = {"hello","hello,world",""}
    -- Run tests with ',' deliminators
    print("Comma deliminator tests")
    for _,test in ipairs(tests) do
        print("==>" .. test)
        result = split(test, ",")
        for i,token in ipairs(result) do
            print(i .. "::" .. token)
        end
    end

    print()

    -- Run tests with 'l' deliminators
    print("l deliminator tests")
    for _,test in ipairs(tests) do
        print("==>" .. test)
        result = split(test, "l")
        for i,token in ipairs(result) do
            print(i .. "::" .. token)
        end
    end
end