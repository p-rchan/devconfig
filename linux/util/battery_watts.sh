#!/bin/sh
#awk '{print $1*10^-6 " W"}' /sys/class/power_supply/BAT1/power_now
BAT="BAT1"
amps=`awk '{print $1*10^-6}' /sys/class/power_supply/${BAT}/current_now`
volts=`awk '{print $1*10^-6}' /sys/class/power_supply/${BAT}/voltage_now`
#echo "${amps} A, ${volts} V"
watts=$( echo "${amps} * ${volts}" | bc )
echo "${amps}A, ${volts}V, ${watts}W"
