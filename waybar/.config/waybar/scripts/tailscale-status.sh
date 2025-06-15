#!/bin/bash

# Check if tailscaled service is active
if ! systemctl is-active --quiet tailscaled; then
    echo "{\"text\":\"󰣫\",\"class\":\"disconnected\"}"
fi

# Check if tailscale client is running
STATUS=$(tailscale status 2>/dev/null)
if [[ "$STATUS" == "Tailscale is stopped." ]]; then
    echo "{\"text\":\"󰣫\",\"class\":\"disconnected\"}"
fi

# Get IPv4 address
CODE=$(tailscale ip -4 2>/dev/null)
if [[ -n "$CODE" ]]; then
    echo "{\"text\":\"$CODE 󰟐 \",\"class\":\"connected\"}"
else
    echo "{\"text\":\"󰣫\",\"class\":\"disconnected\"}"
fi
