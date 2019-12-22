#!/usr/local/bin/lua -i

-- The major modification here is the addition of the count variable
-- This allows us to easily track how many items are in the queue
function listNew()
    return {first = 0, last = -1, count = 0}
end

function pushFirst(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value

    -- Here we increment by one since pushing adds one element to the queue
    list.count = list.count + 1
end

function pushLast(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value

    -- Here we increment by one since pushing adds one element to the queue
    list.count = list.count + 1
end

function popFirst(list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil
    list.first = first + 1

    -- Here we decrement the count, and if it hits zero we reset
    list.count = list.count - 1
    if list.count <= 0 then
        list.first = 0
        list.last = -1
    end
    return value
end

function popLast(list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil
    list.last = last - 1

    -- Here we decrement the count, and if it hits zero we reset
    list.count = list.count - 1
    if list.count <= 0 then
        list.first = 0
        list.last = -1
    end
    return value
end

function test()
    local list = listNew()

    -- If the function is working, then we should see a, b, c come out in order
    -- The first and last indexes should be 0:-1 for the first and last print
    print(list.first .. ' : ' .. list.last)
    pushFirst(list, "b")
    pushFirst(list, "a")
    pushLast(list, "c")
    print(list.first .. ' : ' .. list.last)
    print(popFirst(list))
    print(popFirst(list))
    print(popFirst(list))
    print(list.first .. ' : ' .. list.last)
end
