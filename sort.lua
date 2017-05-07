
function show(m,x)
 io.write(m,"\n\t")
 local i=1
 while x[i] do
  io.write(x[i])
  i=i+1
  if x[i] then io.write(",") end
 end
 io.write("\n")
end

function qsort(x, b, e, f)
    if e <= b then return end

    local pivot = x[b]
    local i = b
    local j = b + 1
    while j <= e do
        if (f(x[j], pivot)) then
            i = i + 1
            x[j], x[i] = x[i], x[j]
        end
        j = j + 1
    end
    x[b], x[i] = x[i], x[b]

    qsort(x, b, i - 1, f)
    qsort(x, i + 1, e, f)

end

function insertion_sort(x, f)
    local n = #x
    for j=2,n do 
        local key = x[j]
        local i = j-1
        while i>0 and x[i]>key do
            if (f(x[i], key)) then 
                x[i+1] = x[i] 
                i = i - 1
            end
        end
        x[i+1] = key
    end
end

--|--------- heap sort ----------------
function max_heapify(x, node, n)
    local lchild = node*2
    local rchild = node*2+1
    local largest = node

    if lchild<=n and x[lchild]>x[node] then
        largest = lchild
    end
    if rchild<=n and x[rchild]>x[largest] then
        largest = rchild
    end

    if largest~=node then
        x[node], x[largest] = x[largest], x[node]
        max_heapify(x, largest, n)
    end
end

function build_max_heap(x)
    for i=#x/2,1,-1 do
        max_heapify(x,i,#x)
    end
end

function heap_sort(x)
    build_max_heap(x)
    local hsize = #x
    for i=#x,2,-1 do
        x[1], x[i] = x[i], x[1]
        hsize = hsize - 1
        max_heapify(x,1,hsize)
    end
end
----------- heap sort --------------|--

function counting_sort(a)
    local n = #a
    local c = {}
    local max_num = math.max(table.unpack(a)) -- the length of table 'c' is the max integer in 'a'
    for i=1,max_num do c[i]=0 end
    for i=1,n do c[a[i]]=c[a[i]]+1 end
    for i=2,max_num do c[i]=c[i]+c[i-1] end
    local b = {}
    for i=n,1,-1 do
        b[c[a[i]]] = a[i]
        c[a[i]] = c[a[i]] - 1
    end

    return b
end

function test_qsort()
    local data = {9,10,8,1,2,7,6,5,4,3}
    show("origin", data)
    qsort(data, 1, #data, function (x,y) return x > y end)
    show("after", data)
end
function test_insertionsort()
    local data = {9,10,8,1,2,7,6,5,4,3}
    show("origin", data)
    insertion_sort(data, function (x,y) return x > y end)
    show("after", data)
end
function test_heap_sort()
    --local data = {16,4,10,14,7,9,3,2,8,1}
    local data = {9,10,8,1,2,7,6,5,4,3}
    show("origin", data)
    --max_heapify(data, 2, #data)
    --build_max_heap(data)
    heap_sort(data)
    show("after", data)
end
function test_counting_sort()
    local data = {9,1,10,8,1,7,6,10,4,7,3,100}
    show("origin", data)
    local sorted_data = counting_sort(data)
    show("after", sorted_data)
end


--[[
test_qsort()
test_insertionsort()
test_heap_sort()
--]]

test_counting_sort()

