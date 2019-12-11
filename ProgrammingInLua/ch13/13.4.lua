#!/usr/local/bin/lua -i

-- This function takes in an integer as its only argument, and returns the number of 1's in it's representation
-- It also returns the number of 0's, because I'm nice
function hammingWeight(target)
    local oneCounter = 0
    local zeroCounter = 0
    while(target > 0) do
        if target & 1 == 1 then
            oneCounter = oneCounter + 1
        else
            zeroCounter = zeroCounter + 1
        end
        target = target >> 1
    end
    return oneCounter, zeroCounter
end

-- Bonus solution, 13.3
-- If the Hamming weight is 1, then the number is a power of 2
function isPowerOfTwo(target)
    return hammingWeight(target) == 1
end

function test()
    for i=0, 16 do
        ones, zeros = hammingWeight(i)
        --print(i .. ' : ' .. ones .. ', ' .. zeros)
        print(string.format("%2i : %i, %i%s", i, ones, zeros, (isPowerOfTwo(i) and ", Power of Two!") or ""))
    end
end

