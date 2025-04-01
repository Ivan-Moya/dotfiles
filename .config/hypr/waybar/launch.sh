#!/bin/bash
#quit al previuos instances
killall waybar
pkill waybar
sleep 0.2

waybar -c ~/.config/hypr/waybar/myconfig -s ~/.config/hypr/waybar/style.css
