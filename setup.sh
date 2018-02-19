cat << EOF >> /boot/config.txt

## CAN
dtparam=spi=on
dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25
dtoverlay=spi-bcm2835-overlay

EOF

apt install -y bluez pulseaudio pulseaudio-module-bluetooth pulseaudio-module-zeroconf

cp /etc/bluetooth/main.conf /etc/bluetooth/main.conf.orig
cp kodi-a2dp/main.conf /etc/bluetooth/main.conf

cp kodi-a2dp/audio.conf /etc/bluetooth/audio.conf

cp /etc/dbus-1/system.d/bluetooth.conf /etc/dbus-1/system.d/bluetooth.conf.orig
cp kodi-a2dp/bluetooth.conf /etc/dbus-1/system.d/bluetooth.conf

cp /etc/pulse/system.pa /etc/pulse/system.pa.orig
cp kodi-a2dp/system.pa /etc/pulse/system.pa
