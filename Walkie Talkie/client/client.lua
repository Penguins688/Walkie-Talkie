local socket = require("socket")
local client = assert(socket.connect("localhost", 8080))

client:settimeout(0)

print("Connected to the server. Type your messages below:")

while true do
    local input = io.read("*line")
    if input then
        client:send(input .. "\n")
    end

    local message, err = client:receive()
    if message then
        print("Received: " .. message)
    end

    socket.sleep(0.01) 
end
