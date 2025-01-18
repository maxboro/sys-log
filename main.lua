-- CPU utilization in %
function get_cpu()
    local handle = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'")
    local cpu_util = handle:read("*a")
    handle:close()
    cpu_util = cpu_util:match("^%s*(.-)%s*$") -- Trim spaces
    return cpu_util
end