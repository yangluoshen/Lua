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

function partition(x, b, e)
    if b>=e then return end
    local pivot = x[e]
    local i = b
    local j = e-1
    while true do
        while i<=j and x[i]<pivot do i=i+1 end
        while i<=j and x[j]>pivot do j=j-1 end
            if i>j then break end
            x[i], x[j] = x[j], x[i]
            i=i+1;j=j-1
    end
    x[i], x[e] = x[e], x[i]
    return i
end

function randomized_partition(x, b, e)
    local r = math.fmod(math.random(os.time()), e-b) + b + 1
    x[r], x[e] = x[e], x[r]
    return partition(x,b,e)
end

function randomized_select(x, b, e, i)
    if e==b then return x[b] end
    local q = randomized_partition(x, b, e)
    local k = q-b+1
    if k==i then return x[q]
    elseif i<k then
        return randomized_select(x,b,q-1,i)
    else
        return randomized_select(x,q+1,e,i-k)
    end
end

data = {12,9,1,3,8,2,10,4,5,6,11}

show("origin", data)
if N<=#data then
value = randomized_select(data, 1, #data, N)
print ("value:", value);
else
print ("N is not valid")
end
show("after", data)
