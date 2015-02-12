sw = { MID = 79, ON = 89, OFF = 69 }
servo = require("servo") servo.init(3)
srv:listen(80,function(conn) 
 conn:on("receive", function(client,request)
  local buf = "<html><body><form>Light: <select name=\"p\" onchange=\"form.submit()\">"
  local _,_,method,path = string.find(request, "([A-Z]+) (.+) HTTP")
  local _,_,vars = string.find(path, ".+?(.+)")
  local _GET = {}
  if(vars~=nil) then for k,v in string.gmatch(vars,"(%w+)=(%w+)") do _GET[k]=v end end
  if( (_GET.s~=nil) and (_GET.v~=nil) ) then sw[_GET.s]=_GET.v end
  if(_GET.p~=nil) then servo.write(sw[_GET.p],1) end
  tmr.alarm( 0, 750, 0, function() servo.write(sw.MID,1) end )
  for _,i in next,{"ON","OFF"} do buf=buf.."<option"..( _GET.p==i and " selected=true>" or ">" )..i.."</option>" end
  buf = buf.."</select></form></body></html>"
  client:send(buf) client:close() collectgarbage()
 end)
end)
