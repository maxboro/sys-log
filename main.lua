-- CPU utilization in %
function get_cpu()
    local handle = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'")
    local cpu_util = handle:read("*a")
    handle:close()
    cpu_util = cpu_util:match("^%s*(.-)%s*$") -- Trim spaces
    return cpu_util
end

-- RAM used, in MB
function get_ram()
    local handle = io.popen("free -m | grep Mem | awk '{print $3}'")
    local used_ram = handle:read("*a")
    handle:close()
    used_ram = used_ram:match("^%s*(.-)%s*$") -- Trim spaces
    return used_ram
end
