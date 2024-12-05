#!/bin/bash

# get all the info
gpu_type=$(supergfxctl -g)
power_profile=$(asusctl profile -p | grep profile | awk '{print $NF}')
sensors_out=$(sensors)
gpu_fan=$(echo "$sensors_out" | grep gpu_fan | awk -F: '{print $2}' | sed s'/ //g')
cpu_fan=$(echo "$sensors_out" | grep cpu_fan | awk -F: '{print $2}' | sed s'/ //g')
battery_draw_amps=$(echo "$sensors_out" | grep -A 3 BAT | grep -E '.*A\s+' | awk '{print $2}')
battery_draw_volts=$(echo "$sensors_out" | grep -A 3 BAT | grep -E '.*V\s+$' | awk '{print $2}')
battery_draw_watts=$(echo "$sensors_out" | grep -A 3 BAT | grep -E '.*W\s+$' | awk '{print $2}')
cpu_governor=$(cpupower frequency-info -p | grep governor | awk '{print $3}' | sed 's/"//g')
# nvidia_first_line=$nvidia_status|head -1 | grep 'failed'
if [[ -z "$battery_draw_watts" ]]; then
  battery_draw_watts=$(echo "${battery_draw_amps} * ${battery_draw_volts}" | bc)
elif [[ -z "$battery_draw_amps" ]]; then
  battery_draw_amps=$(echo "${battery_draw_watts} / ${battery_draw_volts}" | bc)
fi

#output basics
echo "GPU:$gpu_type, Fan: $gpu_fan"
echo "PwrProfile: $power_profile, $cpu_governor"
echo "Battery Draw: ${battery_draw_amps}A, ${battery_draw_volts}V, ${bat_draw_watts}W"

#output nvidia stuff if its on
case $gpu_type in
Hybrid)
  nvidia_status=$(nvidia-smi --format=csv --query-gpu=temperature.gpu,power.draw,memory.used,utilization.gpu,utilization.memory | tail -1 | awk -F, '{print "GPU Temp:",$1,"C Util:",$4," MUtil:",$5}')
  echo "$nvidia_status"
  ;;
esac
