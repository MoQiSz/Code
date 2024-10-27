local func = {}
    function func:FormatLocation(text, path)
        return string.format(path and path or "CrazyDay/Anime Vanguards/Macro/".."%s.json", text)
    end
    function func:NumberToString(num)
        num = tostring(num)
        if #num > 3 and #num < 10 then
            local lat
            for i = 1, #num do
                if i == 3 then
                    lat = i
                    num = num:sub(1, #num - i)..","..num:sub(#num - i + 1)
                elseif lat and lat + 4 == i then
                    num = num:sub(1, #num - i)..","..num:sub(#num - i + 1)
                end
            end
            return num
        elseif #num > 3 and #num >= 10 then
            local x, c = {}, {}
            local l
            for i = 1, #num do
                table.insert(x, (i * 3))
            end
            for i = 1, #num do
                if i == 3 then
                    table.insert(c, ","..num:sub(#num - i + 1, #num))
                elseif table.find(x, i) then
                    if not l then
                        l = 3
                    else
                        l = l + 3
                    end
                    table.insert(c, ","..num:sub(#num - i + 1, #num - (l and l or 3)))
                end
            end
            for i = 1, #c do
                l = l..c[#c - (i - 1)]
            end
            if not table.find(x, #num) then
                local Last = #num
                local Time = 0
                repeat
                    Time += 1
                    Last += 1
                    task.wait()
                until table.find(x, Last)
                return num:sub(1, Time)..l
            else
                return l:sub(2, #l)
            end
        end
        return num
    end
return func
