#!/bin/bash
# Варианты выбора
options="Performance\nBalanced\nPower Saver"
chosen=$(echo -e "$options" | rofi -dmenu -p "Режим" -i -theme ~/.config/rofi/config.rasi)

case "$chosen" in
    "Performance") powerprofilesctl set performance ;;
    "Balanced") powerprofilesctl set balanced ;;
    "Power Saver") powerprofilesctl set power-saver ;;
esac
