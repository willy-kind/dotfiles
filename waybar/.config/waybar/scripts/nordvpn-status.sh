#!/bin/bash

get_country_code() {
    case "$1" in
        Germany) echo "DEU" ;;
        United\ States) echo "USA" ;;
        United\ Kingdom) echo "GBR" ;;
        France) echo "FRA" ;;
        Canada) echo "CAN" ;;
        Netherlands) echo "NLD" ;;
        Sweden) echo "SWE" ;;
        Norway) echo "NOR" ;;
        Denmark) echo "DNK" ;;
        Finland) echo "FIN" ;;
        Iceland) echo "ISL" ;;
        Switzerland) echo "CHE" ;;
        Australia) echo "AUS" ;;
        Singapore) echo "SGP" ;;
        Japan) echo "JPN" ;;
        *) echo "UNK" ;;  # Unknown
    esac
}

STATUS=$(nordvpn status | grep "Status" | awk '{print $2}')

if [ "$STATUS" = "Connected" ]; then
    COUNTRY=$(nordvpn status | grep "Country" | cut -d ':' -f2 | xargs)
    CODE=$(get_country_code "$COUNTRY")
    echo "{\"text\":\"$CODE 󱐡\",\"class\":\"connected\"}"
else
    echo "{\"text\":\"󱐢\",\"class\":\"disconnected\"}"
fi

