local socket = require("socket")
local server = assert(socket.bind("*", 8080))
local clients = {}

print("Channel number: 8080")

server:settimeout(0)

while true do
    local client = server:accept()
    if client then
        client:settimeout(0)
        table.insert(clients, client)
        print("New client connected.")
    end

    for i, client in ipairs(clients) do
        local message, err = client:receive()
        if not err then
            print(message)
            for _, other_client in ipairs(clients) do
                other_client:send(message .. "\n")
            end
        elseif err == "closed" then
            table.remove(clients, i)
            print("Client disconnected.")
        end
    end

    socket.sleep(0.01)
end
