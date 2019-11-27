#!/usr/local/bin/lua -i
function newpoly (coef)
    return function (x)
        local value = coef[0] or 0
        for exponent,coeficient in ipairs(coef) do
            value = value + (coeficient * (x^exponent))
        end
        return value
    end
end

function test()
    local f = newpoly({[0]=3,0,1})
    print(f(0))
    print(f(5))
    print(f(10))
end