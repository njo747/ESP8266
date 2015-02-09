tries=0
MAX_TRIES=200

function launch()
 print("IP: "..wifi.sta.getip())
 srv=net.createServer(net.TCP)
 dofile("telnet.lua")
-- dofile("servo_toggle.lua")
end

function checkWiFi() 
 if ( tries > MAX_TRIES ) then
  print("Unable to connect")
 else
  ip = wifi.sta.getip()
  if ( ( ip ~= nil ) and ( ip ~= "0.0.0.0" ) ) then
   tmr.alarm( 1 , 500 , 0 , launch )
  else
   tmr.alarm( 0 , 2500 , 0 , checkWiFi)
   tries = tries + 1
  end 
 end 
end

tmr.alarm( 0 , 2500 , 0 , checkWiFi )
