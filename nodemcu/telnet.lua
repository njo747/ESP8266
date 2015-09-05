stcp:listen(23,function(c)
 print("WiFi console connected")
 function spt(s) if (c~=nil) then c:send(s) end end
 node.output(spt,1)
 c:on("receive",function(c,l) node.input(l) end)
 c:on("disconnection",function(c) node.output(nil) end)
end)

