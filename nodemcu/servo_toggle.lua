servo = { MID = 79, ON = 89, OFF = 69 }
gpio.mode(3,1) pwm.setup(3,50,servo.MID)
srv:listen(80,function(conn) 
 conn:on("receive", function(client,request)
  local buf = "<html><body><form>Light: <select name=\"p\" onchange=\"form.submit()\">"
  local _,_,method,path = string.find(request, "([A-Z]+) (.+) HTTP")
  local _,_,vars = string.find(path, ".+?(.+)")
  local _GET = {}
  if(vars~=nil) then for k,v in string.gmatch(vars,"(%w+)=(%w+)") do _GET[k]=v end end
  if( (_GET.s~=nil) and (_GET.v~=nil) ) then servo[_GET.s]=_GET.v end
  pwm.start(3) if(_GET.p~=nil) then pwm.setduty(3,servo[_GET.p]) end
  tmr.alarm( 0, 750, 0, function() pwm.setduty(3,servo.MID) end )
  tmr.alarm( 1, 1500, 0, function() pwm.stop(3) end )
  for _,i in next,{"ON","OFF"} do buf=buf.."<option"..( _GET.p==i and " selected=true>" or ">" )..i.."</option>" end
  buf = buf.."</select></form></body></html>"
  client:send(buf) client:close() collectgarbage()
 end)
end)
