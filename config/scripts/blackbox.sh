#!/usr/bin/env bash
set -oue pipefail

echo "-- Removing gnome-terminal in favor of the BlackBox flatpak --"
rpm-ostree override remove gnome-terminal gnome-terminal-nautilus

echo "-- Installing OpenInBlackBox for Nautilus integration --"
if [[ ! -d /usr/share/nautilus-python/extensions/ ]]; then
    mkdir -v -p /usr/share/nautilus-python/extensions/
fi
curl https://raw.githubusercontent.com/ppvan/nautilus-open-in-blackbox/main/nautilus-open-in-blackbox.py > /usr/share/nautilus-python/extensions/blackbox_extension.py

echo "-- Setting BlackBox as default terminal --"
mkdir -p /usr/share/xdg-terminals
cp /usr/share/applications/com.raggesilver.BlackBox.desktop /usr/share/xdg-terminals/com.raggesilver.BlackBox.desktop
echo "X-ExecArg=-c" >> /usr/share/xdg-terminals/com.raggesilver.BlackBox.desktop
curl https://raw.githubusercontent.com/Vladimir-csp/xdg-terminal-exec/master/xdg-terminal-exec > /usr/bin/xdg-terminal-exec
chmod +x /usr/bin/xdg-terminal-exec
