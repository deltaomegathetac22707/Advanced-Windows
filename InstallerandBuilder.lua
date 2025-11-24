shell.run("pastebin get 6UV4qfNF /libs/crypt.lua")

package.path = package.path .. ";/libs/?.lua"

local crypt = require "crypt"

_G.macCalc = {}

local mac = tostring(crypt.digest(tonumber((os.getComputerID() * math.random(100)), 16)))

local bits = {}

for i = 1, #mac do
    local byte = mac:byte(i)
    for bitpos = 7, 0, -1 do
        table.insert(bits, bit32.band(bit32.rshift(byte, bitpos), 1))
    end
end


local mac = {}
local index = 1

for start = 1, 48, 8 do
    local byteValue = 0
    local finish = start + 7

    -- build byte from 8 bits
    for i = start, finish do
        local pos = 7 - (i - start)   -- 7..0
        byteValue = byteValue + bits[i] * 2^pos
    end

    mac[index] = string.format("%02X", byteValue)
    index = index + 1
end

print("Wired: " .. table.concat(mac, ":"))

local filePath = "/sysfiles/.mac"

-- Open the file in write mode ("w") to overwrite or create it
local file = fs.open(filePath, "w")

for i = 1, #mac do
    file.writeLine(mac[i])
end

-- Close the file
file.close()

print("MAC Address Created.")

