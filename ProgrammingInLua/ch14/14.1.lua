#!/usr/local/bin/lua -i

function addSparseMatricies(a, b)
    -- First we figure out which rows exist in either matrix
    -- This allows the matricies to not only have sparse rows, but missing rows entirely
    -- Allowing arrays such as
    --
    -- Notice that there are both empty rows and empty columns, so we cannot trust any length operator
    --
    -- 1 0 0 0   0 0 0 1   1 0 0 1
    -- 0 1 0 0 + 0 2 0 0 = 0 3 0 0
    -- 0 0 0 0   0 0 0 0   0 0 0 0
    -- 0 0 0 1   1 0 0 0   1 0 0 1

    local rows = {}
    for r, row in pairs(a) do
        rows[r] = true
    end

    for r, row in pairs(b) do
        rows[r] = true
    end

    local result = {}
    for r, _ in pairs(rows) do
        print('row : ' .. r)
        if not a[r] then result[r] = b[r] print('grabbing b')
        elseif not b[r] then result[r] = a[r] print('grabbing a')
        else
            print('calculating')
            result[r] = {}
            
            for c, av in pairs(a[r]) do
                result[r][c] = av
            end

            for c, bv in pairs(b[r]) do
                result[r][c] = result[r][c] and result[r][c] + bv or bv
            end
        end
    end
    return result
end

function printSparseMatrix(a, size)
    for i=1, size do
        local row = ''
        for j=1,size do
            row = row .. (a[i] and a[i][j] or 0) .. ' '
        end
        print(row)
    end
end

function test()
    local a = {[1] = {[1] = 1}, [2] = {[2] = 2}, [4] = {[4] = 1}}
    local b = {[1] = {[1] = 1, [4] = 1}, [4] = {[1] = 1}}

    local c = addSparseMatricies(a, b)

    printSparseMatrix(a,4)
    print("+")
    printSparseMatrix(b,4)
    print("=")
    printSparseMatrix(c,4)
end