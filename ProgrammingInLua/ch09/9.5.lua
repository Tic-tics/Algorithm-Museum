#!/usr/local/bin/lua -i

-- This file contains solutions for both 9.4 and 9.5

-- From the text
function disk (cx, cy, r)
    return function(x, y)
        return (x - cx)^2 + (y - cy)^2 <= r^2
    end
end

-- From the text
function rect (left, right, bottom, top)
    return function(x, y)
        return left <= x and x <= right and
            bottom <= y and y <= top
    end
end

-- From the text
function complement (r)
    return function (x, y)
        return not r(x, y)
    end
end

-- From the text
function union (r1, r2)
    return function (x, y)
        return r1(x, y) or r2(x, y)
    end
end

-- From the text
function difference (r1, r2)
    return function (x, y)
        return r1(x, y) and not r2(x, y)
    end
end

-- From the text
function translate (r, dx, dy)
    return function (x, y)
        return r(x - dx, y - dy)
    end
end

-- From the text
function plot (r, M, N)
    io.write("P1\n", M, " ", N, "\n")
    for i = 1, N do
        local y = (N - i*2)/N
        for j = 1, M do
            local x = (j*2 - M)/M
            io.write(r(x,y) and "1" or "0")
        end
        io.write("\n")
    end
end

-- Function to fulfill 9.5
function rotate (r, theta)
    return function (x, y)
        local xp = x * math.cos(theta) - y * math.sin(theta)
        local yp = y * math.cos(theta) + x * math.sin(theta)
        return r(xp, yp)
    end
end

function test()
    -- First we demonstrate 9.4
    local c1 = disk(0,0,1)
    local north_wax_crescent = difference(c1, translate(c1, -0.3, 0))
    plot(north_wax_crescent, 100, 100)

    -- Then 9.5
    plot(rotate(north_wax_crescent, -math.pi/4), 100, 100)
end

