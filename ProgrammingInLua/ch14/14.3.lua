#!/usr/local/bin/lua -i

local function name2node(graph, name)
    local node = graph[name]
    if not node then
        -- Node does not exist, make a new one
        node = {name = name, arcs = {}}
        graph[name] = node
    end
    return node
end

function readgraph(filename)
    local f = assert(io.open(filename, 'r'))

    local graph = {}
    for line in f:lines() do
        -- split line into two names
        local namefrom, arclabel, nameto = string.match(line, "(%S+)%s(%d+)%s(%S+)")
        -- find corresponding nodes
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        -- adds 'to' to the adjacent set of 'from'
        from.arcs[#from.arcs+1] = {label = arclabel, target = to}
    end
    f:close()
    return graph
end

function findpath(curr, to, path, visited)
    path = path or {}
    visited = visited or {}
    if visited[curr] then -- We have already visited this node
        return nil
    end

    -- Mark current as visited and append to path
    visited[curr] = true
    path[#path+1] = curr

    -- If we have reached our destination, return
    if curr == to then
        return path
    end

    -- Otherwise continue trying depth first search
    for i, arc in ipairs(curr.arcs) do
        local p = findpath(arc.target, to, path, visited)
        if p then return p end
    end

    table.remove(path)
end

function printpath(path)
    for i = 1, #path do
        print(path[i].name)
    end
end

function test()
    g = readgraph("14.3.graph")
    a = name2node(g, "a")
    d = name2node(g, "d")
    p = findpath(a, d)
    if p then printpath(p) end
end
