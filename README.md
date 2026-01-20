# 🛸 Дот Файлы под свей в серебрянных тонах ого

## 📸 Скриншоты
<img width="1920" height="1080" alt="изображение" src="https://github.com/user-attachments/assets/ad30fea4-cb6a-43bf-b853-12f42482a5e7" /> <img width="1920" height="1080" alt="изображение" src="https://github.com/user-attachments/assets/bdbd0b47-ae0f-49b3-b988-787627f17016" />



## 🛠 Зависимости (Packages)

### Основные компоненты (Native)
Для полной работоспособности установлены следующие пакеты:
* **WM:** `sway`, `swaybg`, `swaync`
* **UI:** `waybar`, `rofi`, `kitty`
* **Tools:** `wl-clipboard`, `cliphist`, `grim`, `slurp`, `brightnessctl`, `wireplumber`, `pavucontrol`, `dexptablet`
* **Apps:** `nautilus`, `firefox`, `telegram-desktop`

### Шрифты и Темы
Интерфейс завязан на Nerd Fonts для отображения иконок:
* **Шрифт:** `JetBrainsMono Nerd Font`
* **Иконки:** `Papirus-Dark` 
* **Курсор:** `Adwaita` 
* **Тема:** `Adwaita-dark` 

### Flatpak Приложения
Конфиг поддерживает запуск следующих приложений через Flatpak:
| Приложение | ID Пакета |
| :--- | :--- |
| **Obsidian** | `md.obsidian.Obsidian` |
| **Rnote** | `com.github.flxzt.rnote` |
| **G4Music** | `com.github.neithern.g4music` |
| **Discord** | `com.discordapp.Discord` |
| **Flatseal** | `com.github.tchx84.Flatseal` |
| **Gradia** | `com.github.taniyarasam.Gradia` |
| **Sober** | `org.vinegarhq.Sober` |

---

## ⌨️ Горячие клавиши (Keybindings)
*Модификатор `$mod` = **Win*** 

### Запуск приложений 
* `$mod + Enter` — Терминал (Kitty)
* `$mod + Shift + W` — Меню приложений (Rofi)
* `$mod + Shift + E` — Файловый менеджер (Nautilus)
* `$mod + Shift + B` — Браузер (Firefox)
* `$mod + Shift + T` — Telegram
* `$mod + Shift + V` — История буфера обмена
* `$mod + Shift + O` — Obsidian
* `$mod + Shift + R` — Rnote
* `$mod + Shift + M` — G4Music

### Управление окнами 
* `$mod + Q` — Закрыть окно
* `$mod + F` — Полный экран
* `$mod + Shift + Space` — Переключить плавающий режим
* `$mod + H/J/K/L` — Перемещение фокуса (Vim-style)
* `$mod + Shift + H/J/K/L` — Перемещение окна
* `$mod + R` — Режим изменения размера

### Система
* `Print` — Скриншот области
* `Shift + Print` — Скриншот всего экрана
* `Alt + Shift` — Смена раскладки (US/RU)
* `F-клавиши` — Громкость, яркость, мут микрофона (wpctl/brightnessctl)
* `$mod + Shift + BackSpace` — Выход из Sway

---

## 🚀 Установка

Конфиг поставляется с универсальным установщиком для **Arch**, **Fedora** и **Debian**.

1. **Клонируйте репозиторий:**
   ```bash
   git clone https://github.com/efimkish/dotfiles-sway.git
   cd dotfiles-sway
   ./install.sh
