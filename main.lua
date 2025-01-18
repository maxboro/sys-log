local socket = require("socket")

-- CPU utilization in %
function get_cpu()
    local handle = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'")
    local cpu_util = handle:read("*a")
    handle:close()
    cpu_util = cpu_util:match("^%s*(.-)%s*$") -- Trim spaces
    return cpu_util or "N/A"
end

-- RAM used, in MB
function get_ram()
    local handle = io.popen("free -m | grep Mem | awk '{print $3}'")
    local used_ram = handle:read("*a")
    handle:close()
    used_ram = used_ram:match("^%s*(.-)%s*$") -- Trim spaces
    return used_ram or "N/A"
end

-- calculate tracked metrics
function get_metric_values()
    metrics = {}
    metrics["cpu_utilization"] = get_cpu()
    metrics["ram_utilization"] = get_ram()
    return metrics
end

function clean_logfile()
    local logfile = io.open("logfile.log", "w")
    logfile:close(logfile)
end

function write_to_logfile(line)
    local logfile = io.open("logfile.log", "a")
    logfile:write(line.."\n")
    logfile:close()
end

function log(metrics)
    local metrics_string = string.format("CPU Utilization: %s%%, RAM Utilization: %s MB", metrics.cpu_utilization, metrics.ram_utilization)
    local timestamp = os.date().." | "
    local logline = timestamp..metrics_string
    print(logline)
    write_to_logfile(logline)
end

function exec_cycle_of_logging()
    local metrics = get_metric_values()
    log(metrics)
end

function main()
    clean_logfile()
    while (true)
    do
        exec_cycle_of_logging()
        socket.sleep(1)
    end
end

main()