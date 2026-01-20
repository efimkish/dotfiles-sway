#!/bin/bash
# Ищем сети и показываем в Rofi
chosen=$(nmcli -t -f SSID dev wifi | grep -v '^--' | sort -u | rofi -dmenu -p "Wi-Fi" -i -theme ~/.config/rofi/config.rasi)

if [ -n "$chosen" ]; then
    # Подключение (nmcli спросит пароль в терминале или GUI-агенте, если нужно)
    nmcli dev wifi connect "$chosen"
fi
