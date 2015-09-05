#!/opt/local/bin/bash

esp_send(){ echo "$@" >&4 ; }

esp_parse()
{
	echo "$a"
}

exec 4<> /dev/tcp/192.168.1.69/23

{ while read a; do esp_parse "$a"; done } <&4 &

sleep 2
esp_send "print(wifi.sta.getip())"
sleep 2
esp_send "for k,v in pairs(file.list()) do print(k..\", \"..v) end"
sleep 2
esp_send "gpio.mode(3,1)"
esp_send "pwm.setup(3,50,76)"
esp_send "pwm.start(3)"
sleep 2
esp_send "pwm.setduty(3,50)"
sleep 2
esp_send "pwm.setduty(3,100)"
sleep 2

exec 4<&-
