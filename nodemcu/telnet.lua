srv:listen(23,function(c)
 print("WiFi console connected")
 function sput(str) if (c~=nil) then c:send(str) end end
 node.output(sput,1)
 c:on("receive",function(c,l) node.input(l) end)
 c:on("disconnection",function(c) node.output(nil) end)
end)

