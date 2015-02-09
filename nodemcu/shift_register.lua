_p = { D = 3, C = 4, L = 2 }
for _,i in next,_p do gpio.mode(i,1); gpio.write(i,0) end

function shift_out(byte)
 gpio.write(_p.L,0)
 for b=1,8 do gpio.write(_p.C,0); gpio.write(_p.D,( bit.isset(byte,b) and 1 or 0 )); gpio.write(_p.C,1) end
 gpio.write(_p.L,1)
end
