servo = {
	min = 50, max = 105,

	init = function (pin)
		self.pin = pin
		gpio.mode(pin,1)
		pwm.setup(pin,50,((min+max)/2))
	end,

	write = function (val,fi)
		pwm.start(pin)
		if(val<min) then val = min end
		if(val>max) then val = max end
		pwm.setduty(pin,val)
		if(fi) then tmr.alarm( 1, 1000, 0, function() pwm.stop(3) end ) end
	end
}
