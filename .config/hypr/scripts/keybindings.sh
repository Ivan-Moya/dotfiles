#!/bin/bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# -----------------------------------------------------
# Resolve the keybinding file relative to this script
# -----------------------------------------------------
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_file="$script_dir/../keybinding.conf"

# -----------------------------------------------------
# Path to keybindings config file
# -----------------------------------------------------
echo "Reading from: $config_file"

keybinds=$(awk '
    /^[[:space:]]*#/ { next }
    /^[[:space:]]*$/ { next }
    $1 ~ /^(bind|binde|bindl|bindm)$/ {
        line = $0

        # Replace the string "$mainMod" with "SUPER" for display purposes.
        gsub(/\$mainMod/, "SUPER", line)

        # Remove the binding keyword and normalize whitespace.
        sub(/^[[:space:]]*(bind|binde|bindl|bindm)[[:space:]]*=[[:space:]]*/, "", line)

        # Split into modifier, key, and command fields.
        n = split(line, parts, ",")
        if (n < 3) next

        mod = parts[1]
        key = parts[2]
        cmd = parts[3]
        for (i = 4; i <= n; i++) {
            cmd = cmd "," parts[i]
        }

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", mod)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", cmd)

        print mod "  + " key "\r" cmd
    }
' "$config_file")

sleep 0.2
rofi -dmenu -i -markup -eh 2 -replace -p "Keybinds" -config ~/.config/hypr/rofi/config-compact.rasi <<<"$keybinds"
