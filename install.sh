#!/usr/bin/env bash
set -e

# ======================================================
# Universal Dotfiles Installer (SwayWM, Kitty, Fastfetch)
# Works on Arch/Manjaro, Fedora (with RPM Fusion), Debian/Ubuntu
# ======================================================

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
echo "Detected OS: $OS"

# ======================================================
# Update system and install native packages
# ======================================================
echo "=== Installing native packages ==="

if [ "$OS" = "arch" ]; then
    sudo pacman -Syu --needed --noconfirm \
    sway swaybg waybar rofi kitty nautilus firefox polkit-gnome xdg-desktop-portal-wlr \
    wl-clipboard cliphist grim slurp brightnessctl wireplumber pavucontrol blueman networkmanager gsimplecal telegram-desktop dexptablet \
    ttf-jetbrains-mono-nerd papirus-icon-theme adwaita-icon-theme

elif [ "$OS" = "fedora" ]; then
    echo "=== Adding RPM Fusion repositories ==="
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm || true
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || true

    echo "=== Installing native packages + multimedia codecs ==="
    sudo dnf install -y --skip-unavailable \
    sway swaybg waybar rofi kitty nautilus firefox xdg-desktop-portal-wlr \
    wl-clipboard grim slurp brightnessctl wireplumber pavucontrol blueman NetworkManager telegram-desktop \
    papirus-icon-theme adwaita-icon-theme || true

    # Multimedia codecs
    sudo dnf install -y --skip-unavailable @multimedia gstreamer1-plugins-{bad-free,good,ugly} ffmpeg || true

elif [ "$OS" = "debian" ]; then
    sudo apt update
    sudo apt install -y \
    sway swaybg waybar rofi kitty nautilus firefox policykit-1 xdg-desktop-portal-wlr \
    wl-clipboard cliphist grim slurp brightnessctl pipewire wireplumber pavucontrol blueman network-manager gsimplecal telegram-desktop \
    fonts-jetbrains-mono papirus-icon-theme adwaita-icon-theme || true
fi

# ======================================================
# Flatpak & Flathub
# ======================================================
echo "=== Installing Flatpak apps ==="

if ! command -v flatpak &>/dev/null; then
    echo "Installing Flatpak..."
    if [ "$OS" = "arch" ]; then
        sudo pacman -S --needed --noconfirm flatpak
    elif [ "$OS" = "fedora" ]; then
        sudo dnf install -y flatpak
    elif [ "$OS" = "debian" ]; then
        sudo apt install -y flatpak
    fi
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
md.obsidian.Obsidian \
com.github.flxzt.rnote \
com.github.neithern.g4music \
com.discordapp.Discord \
com.github.tchx84.Flatseal \
org.vinegarhq.Sober || true

# ======================================================
# GTK theme & cursor
# ======================================================
echo "=== Setting GTK theme and cursor ==="
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark" || true
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita" || true

# ======================================================
# Link dotfiles
# ======================================================
echo "=== Linking dotfiles ==="

CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

for conf in sway kitty fastfetch waybar; do
    if [ -d "$PWD/$conf" ]; then
        ln -sf "$PWD/$conf" "$CONFIG_DIR/$conf"
        echo "Linked $conf"
    fi
done

echo "=== Done! ==="
echo "You may need to logout/login to apply some settings."
