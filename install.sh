#!/usr/bin/env bash
set -e

echo "=== Detecting OS ==="
if [ -f /etc/arch-release ]; then
    OS="arch"
elif [ -f /etc/fedora-release ]; then
    OS="fedora"
elif [ -f /etc/debian_version ]; then
    OS="debian"
else
    echo "Unsupported OS"
    exit 1
fi

# 1. Установка системных пакетов
echo "=== Installing native packages for $OS ==="
if [ "$OS" = "arch" ]; then
    sudo pacman -Syu --needed --noconfirm \
    sway swaybg waybar rofi-wayland kitty nautilus firefox polkit-gnome xdg-desktop-portal-wlr \
    wl-clipboard cliphist grim slurp brightnessctl wireplumber pavucontrol blueman networkmanager \
    gsimplecal telegram-desktop dexptablet ttf-jetbrains-mono-nerd papirus-icon-theme adwaita-icon-theme fastfetch
    
elif [ "$OS" = "fedora" ]; then
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm || true
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || true
    # Добавлен --allowerasing для решения конфликта ffmpeg
    sudo dnf install -y --allowerasing --skip-unavailable \
    sway swaybg waybar rofi-wayland kitty nautilus firefox xdg-desktop-portal-wlr \
    wl-clipboard grim slurp brightnessctl wireplumber pavucontrol blueman NetworkManager telegram-desktop \
    papirus-icon-theme adwaita-icon-theme @multimedia gstreamer1-plugins-{bad-free,good,ugly} ffmpeg fastfetch

elif [ "$OS" = "debian" ]; then
    sudo apt update && sudo apt install -y \
    sway swaybg waybar rofi kitty nautilus firefox xdg-desktop-portal-wlr \
    wl-clipboard cliphist grim slurp brightnessctl wireplumber pavucontrol blueman network-manager \
    gsimplecal telegram-desktop fonts-jetbrains-mono papirus-icon-theme adwaita-icon-theme fastfetch
fi

# 2. Flatpak приложения
echo "=== Installing Flatpak apps ==="
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub \
md.obsidian.Obsidian com.github.flxzt.rnote com.github.neithern.g4music \
com.discordapp.Discord com.github.tchx84.Flatseal org.vinegarhq.Sober \

# 3. Линковка конфигов (С ПОЛНОЙ ПЕРЕЗАПИСЬЮ)
echo "=== Linking dotfiles to ~/.config ==="
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

# Список папок для линковки (добавь свои, если нужно)
DIRS=("sway" "waybar" "kitty" "rofi" "swaync" "fastfetch")

for dir in "${DIRS[@]}"; do
    if [ -d "$PWD/$dir" ]; then
        echo "Linking $dir..."
        rm -rf "$CONFIG_DIR/$dir" # Удаляем старую папку/ссылку, чтобы не было ошибки
        ln -sf "$PWD/$dir" "$CONFIG_DIR/"
    fi
done

# 4. Делаем скрипты исполняемыми
echo "=== Setting executable permissions for scripts ==="
[ -d "$CONFIG_DIR/waybar/scripts" ] && chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh
[ -d "$CONFIG_DIR/sway/scripts" ] && chmod +x "$CONFIG_DIR/sway/scripts/"*.sh

echo "=== Installation Complete! Please restart Sway. ==="
