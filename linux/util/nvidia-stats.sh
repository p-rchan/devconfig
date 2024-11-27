#!/bin/bash

nvidia_status=$(nvidia-smi --format=csv --query-gpu=temperature.gpu,power.draw,memory.used,utilization.gpu,utilization.memory | tail -1 | awk -F, '{print "GPU Temp:",$1," C Util:",$4," MemUtil:",$5}')
echo $nvidia_status
