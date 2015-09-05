local HOSTNAME = "esp"
-- ..string.format("%x",node.chipid())

local MDNS_IP = "224.0.0.251"
local RESP_H = '\0\0\132\0\0\0\0\1\0\0\0\0'
local RESP_E = '\0\0\1\128\1\0\0\0\120\0\4'

local lip = wifi.sta.getip()

net.multicastJoin(lip,MDNS_IP)
sudp:listen(5353,MDNS_IP)

local ipo = {}
for o in lip:gmatch("%d+") do ipo[#ipo+1]=tonumber(o) end
local ip = string.char(ipo[1],ipo[2],ipo[3],ipo[4])

sudp:on("receive",function(c,p)
 if p:match(HOSTNAME) then
  print("pinged")
  c:send(RESP_H..string.char(HOSTNAME:len())..HOSTNAME..'\5local'..RESP_E..ip)
 end
end)
