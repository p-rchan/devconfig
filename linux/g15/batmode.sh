#!/bin/bash

# Check if we are plugged in
ac_power=$(cat /sys/class/power_supply/ACAD/online)

case $ac_power in
0)
  power_mode="battery"
  asusctl_mode="Quiet"
  keyboard_led="202020"

  # disable these cores
  all_cores=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
  enabled_cores=(0 1 2 3 4 5 6 7 8)
  disabled_cores=(9 10 11 12 13 14 15)

  # limit these cores
  governor=conservative # conservative governor
  max_limit_mhz=2668Mhz # max mhz
  screen_refresh=60

  ;;

1)
  power_mode="plugged"
  asusctl_mode="Balanced"
  keyboard_led="FFFFFF"

  # disable these cores
  all_cores=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
  enabled_cores=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
  disabled_cores=()

  # limit these cores
  governor=ondemand     # conservative governor
  max_limit_mhz=4.94Ghz # max mhz
  screen_refresh=144

  ;;
esac

echo "Setting power mode $power_mode"
#
asusctl profile -P $asusctl_mode
sudo powertop --auto-tune
asusctl led-mode static -c $keyboard_led

#Turn on all CPU cores first
for core_number in "${all_cores[@]}"; do
  echo "turning on core $core_number"
  echo 1 | tee /sys/devices/system/cpu/cpu$core_number/online 2>&1 >/dev/null
done

# Turn off specific CPU cores
for core_number in "${disabled_cores[@]}"; do
  echo "turning off core $core_number"
  echo 0 | tee /sys/devices/system/cpu/cpu$core_number/online 2>&1 >/dev/null
done

# Set CPU frequency governor and max limit
for core_number in "${enabled_cores[@]}"; do
  echo "adjusting frequency on core $core_number to $max_limit_mhz using governor $governor"
  cpupower -c $core_number frequency-set -g $governor -u $max_limit_mhz 2>&1 >/dev/null
done

# Set screen refresh rate
echo "setting screen refresh to $screen_refresh"
xrandr --output eDP-1 --mode 2560x1440 --rate $screen_refresh 2>&1 >/dev/null
