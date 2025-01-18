local socket = require("socket")
local lfs = require("lfs")

-- Create a directory if it doesn't exist
local function create_directory_if_not_exists(dir)
    local attr = lfs.attributes(dir)
    if not attr then
        -- Directory does not exist, create it
        local success, err = lfs.mkdir(dir)
        if success then
            print("Directory created:", dir)
        else
            print("Failed to create directory:", err)
        end
    else
        print("Directory already exists:", dir)
    end
end

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
    local metrics = {}
    metrics["cpu_utilization"] = get_cpu()
    metrics["ram_utilization"] = get_ram()
    return metrics
end

function clean_logfile(logfile_dest)
    local logfile = io.open(logfile_dest, "w")
    logfile:close(logfile)
end

function write_to_logfile(logfile_dest, line)
    local logfile = io.open(logfile_dest, "a")
    logfile:write(line.."\n")
    logfile:close()
end

function log(logfile_dest, metrics)
    local metrics_string = string.format("CPU Utilization: %s%%, RAM Utilization: %s MB", metrics.cpu_utilization, metrics.ram_utilization)
    local timestamp = os.date().." | "
    local logline = timestamp..metrics_string
    print(logline)
    write_to_logfile(logfile_dest, logline)
end

function exec_cycle_of_logging(logfile_dest)
    local metrics = get_metric_values()
    log(logfile_dest, metrics)
end

function get_logfile_dest()
    local logfile_name = "logfile_"..os.date("%Y-%m-%d__%H-%M-%S")..".log"
    local logfile_dest = "./logs/"..logfile_name
    print("Log will be saved to "..logfile_dest)
    return logfile_dest
end

function main()
    create_directory_if_not_exists("logs")
    local logfile_dest = get_logfile_dest()
    clean_logfile(logfile_dest)
    while (true)
    do
        exec_cycle_of_logging(logfile_dest)
        socket.sleep(1)
    end
end

main()