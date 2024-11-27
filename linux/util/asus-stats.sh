#!/bin/bash 
gpu_type=$(supergfxctl -g)
power_profile=$(asusctl profile -p | awk '{print $NF}')
nvidia_first_line=$nvidia_status|head -1 | grep 'failed'

case $gpu_type in
  integrated)
    echo "GPU:$gpu_type Profile: $power_profile"
    ;;
  *)
    nvidia_status=$(nvidia-smi --format=csv --query-gpu=temperature.gpu,power.draw,memory.used,utilization.gpu,utilization.memory | tail -1 | awk -F, '{print "GPU Temp:",$1,"C Util:",$4," MUtil:",$5}')
    echo "GPU: $gpu_type | Profile: $power_profile" 
    echo "$nvidia_status"
    ;;
esac

