#!/bin/bash

STATUS=$(nordvpn status | grep Status | awk '{print $2}')

if [ "$STATUS" = "Connected" ]; then
    echo '{"text":"󱐡 VPN","class":"connected"}'
else
    echo '{"text":"󱐢 No VPN","class":"disconnected"}'
fi

