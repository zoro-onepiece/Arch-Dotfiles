#!/bin/bash

# Battery thresholds
declare -A NOTIFIED
NOTIFIED=( ["15"]=0 ["10"]=0 ["5"]=0 )

while true; do
    BATTERY=$(ls /sys/class/power_supply/ | grep -i bat | head -n 1)
    
    if [ -n "$BATTERY" ]; then
        STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
        CAPACITY=$(cat /sys/class/power_supply/$BATTERY/capacity)
        
        if [ "$STATUS" = "Discharging" ]; then
            for LEVEL in 15 10 5; do
                if [ "$CAPACITY" -le "$LEVEL" ] && [ "${NOTIFIED[$LEVEL]}" -eq 0 ]; then
                    notify-send -u critical "Battery Low" "Battery is at ${CAPACITY}%! Please plug in the charger."
                    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga &
                    NOTIFIED[$LEVEL]=1
                fi
            done
        else
            # Reset notifications when charging
            if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then
                NOTIFIED["15"]=0
                NOTIFIED["10"]=0
                NOTIFIED["5"]=0
            fi
        fi
    fi
    sleep 60
done
