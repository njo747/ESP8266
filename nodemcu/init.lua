stcp=net.createServer(net.TCP)
sudp=net.createServer(net.UDP)

function launch()
 print("IP: "..wifi.sta.getip())
 dofile("telnet.lua")
end

local tries=0

function checkWiFi() 
 if ( tries > 10 ) then
  print("Unable to connect")
 else
  local ip = wifi.sta.getip()
  if ( ( ip ~= nil ) and ( ip ~= "0.0.0.0" ) ) then
   tmr.alarm(1,500,0,launch)
  else
   tmr.alarm(0,2500,0,checkWiFi)
   tries = tries + 1
  end 
 end 
end

tmr.alarm(0,2500,0,checkWiFi)
