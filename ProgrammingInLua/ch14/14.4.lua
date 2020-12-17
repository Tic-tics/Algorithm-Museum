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

-- Calculates the index of a parent
function parent(i)
  -- this defaults the value to 1 for the root.
  -- the root is its own parent
  return math.max(i//2, 1)
end

-- Calculates the index of the left child
function left(i)
  return 2 * i
end

-- Calculates the index of the right child
function right(i)
  return ( 2 * i ) + 1
end

-- Swaps to elements in a table
function swap(heap, l, r)
  local temp = heap[l]
  heap[l] = heap[r]
  heap[r] = temp
end

-- Turns a subset of a list into a heap
-- i is the index of the root of the subheap
function minHeapify(heap, i)
  i = i or 0
  local l = left(i)
  local r = right(i)
  
  local smallest = i
  
  -- locate the smallest node (either the root or children)
  if l <= #heap and heap[l] < heap[i] then
    smallest = l
  end
  
  if r <= #heap and heap[r] < heap[i] then
    smallest = r
  end
  
  -- If the root violates the rule, swap to fix and recurse
  if smallest ~= i then
    swap(heap, i, smallest)
    minHeapify(heap, smallest)
  end
end

-- Pushes a new value into the minHeap
function minHeapPush(heap, node, priority)
  local currentIndex = #heap + 1
  
  heap[currentIndex] = { node=node, priority=priority }
  
  while currentIndex > 1 do
    local p = parent(currentIndex)
    if heap[p].priority > heap[currentIndex].priority then
      -- Bubble up
      swap(heap, p, currentIndex)
      currentIndex = p
    else
      return
    end
  end
end

-- Finds and decreases the priority of a node in the minHeap
function minHeapDecrease(heap, node, priority)
  local found = nil
  for i,v in ipairs(heap) do
    if v.node == node then
      found = i
      break
    end
  end
  
  if found then
    heap[found].priority = priority
    
    local currentIndex = found
    
    while currentIndex do
      local p = parent(currentIndex)
      if heap[p].priority > heap[currentIndex].priority then
        swap(heap, p, currentIndex)
        currentIndex = p
      else
        break
      end
    end
    
    return true
  else return false
  end
end

-- Retrieves the minimum priority node in a minHeap
function minHeapPop(heap)
  if not heap then
    return nil, nil
  end
  
  local element = table.remove(heap, 1)
  
  return element.node, element.priority
end

-- Constructs a path to the destination from a parents table
function buildPath(parents, dest)
  local path = {}
  local current = dest
  
  table.insert(path, dest)
  
  while parents[current] ~= current do
    table.insert(path, 1, parents[current])
    current = parents[current]
  end
  
  return path
end

-- Runs dijkstra's algorithm from the a start node to the destination
function dijkstra(start, dest)
  local q = {} -- the minHeap
  local dists = {} -- tracks the distance to each node
  local visited = {} -- tracks which nodes are visited
  local parents = {} -- tracks the parent of each node
  minHeapPush(q, start, 0)
  dists[start] = 0
  parents[start] = start -- the root's parent is itself
  
  while #q > 0 do
    local current, dist = minHeapPop(q)

    if current == dest then
      return buildPath(parents, dest)
    end
    
    for i,v in ipairs(current.arcs) do
      if not visited[v.target] then
        local tentativeDist = dist + v.label
        
        if not dists[v.target] then
          minHeapPush(q, v.target, tentativeDist)
          dists[v.target] = tentativeDist
          parents[v.target] = current
        elseif tentativeDist < dists[v.target] then
          minHeapDecrease(q, v.target, tentativeDist)
          dists[v.target] = tentativeDist
          parents[v.target] = current
        end
      end
    end
    
    visited[current] = true
  end
  return nil
end

function printpath(path)
    for i = 1, #path do
        print(path[i].name)
    end
end

function test()
    local g = readgraph("14.3.graph")
    local a = name2node(g, "a")
    local d = name2node(g, "d")
    local p = dijkstra(a, d)
    if p then printpath(p) end
    local e = name2node(g, "e")
    print("NOPATH gives", dijkstra(a,e))
end
