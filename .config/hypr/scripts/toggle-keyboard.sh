#!/bin/bash

set -euo pipefail

get_keyboard_device() {
    hyprctl devices 2>/dev/null | awk '
        BEGIN { in_keyboards = 0; want_name = 0; device = "" }
        /^keyboards:/ { in_keyboards = 1; next }
        in_keyboards && /^mice:/ { exit }
        in_keyboards && /^[[:space:]]*Keyboard at / { want_name = 1; next }
        want_name && /^[[:space:]]*name: / {
            sub(/^[[:space:]]*name: /, "")
            device = $0
            exit
        }
        END {
            if (device != "") {
                print device
            } else {
                print "all"
            }
        }
    '
}

get_active_layout() {
    hyprctl devices 2>/dev/null | awk '
        /^[[:space:]]*active keymap:/ {
            sub(/^[[:space:]]*active keymap: /, "")
            print
            exit
        }
    '
}

layout_to_label() {
    case "$1" in
        *Spanish*|*Español*|*ES*|*es*)
            printf 'ES'
            ;;
        *)
            printf 'EN'
            ;;
    esac
}

layout_to_class() {
    case "$1" in
        *Spanish*|*Español*|*ES*|*es*)
            printf 'es'
            ;;
        *)
            printf 'us'
            ;;
    esac
}

if [[ "${1:-}" == "--toggle" ]]; then
    device="$(get_keyboard_device)"
    hyprctl switchxkblayout "$device" next >/dev/null 2>&1 || \
        hyprctl switchxkblayout all next >/dev/null 2>&1
    exit 0
fi

active_layout="$(get_active_layout)"
label="$(layout_to_label "$active_layout")"
css_class="$(layout_to_class "$active_layout")"

printf '{"text":"%s","tooltip":"Click to switch keyboard layout","class":"%s"}\n' "$label" "$css_class"
