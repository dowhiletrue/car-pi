## locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "de_CH.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="en_US.UTF-8"' > /etc/default/locale

cat << EOF > /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="ch"
XKBVARIANT="de_nodeadkeys"
XKBOPTIONS=""

BACKSPACE="guess"
EOF

service keyboard-setup restart

timedatectl set-timezone Europe/Zurich

## PICAN2
cat << EOF >> /boot/config.txt

## CAN
dtparam=spi=on
dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25
dtoverlay=spi-bcm2835-overlay

EOF

## a2dp

apt install -y bluez pulseaudio pulseaudio-module-bluetooth pulseaudio-module-zeroconf

cp /etc/bluetooth/main.conf /etc/bluetooth/main.conf.orig
cp kodi-a2dp/main.conf /etc/bluetooth/main.conf

cp kodi-a2dp/audio.conf /etc/bluetooth/audio.conf

cp /etc/dbus-1/system.d/bluetooth.conf /etc/dbus-1/system.d/bluetooth.conf.orig
cp kodi-a2dp/bluetooth.conf /etc/dbus-1/system.d/bluetooth.conf

cp /etc/pulse/system.pa /etc/pulse/system.pa.orig
cp kodi-a2dp/system.pa /etc/pulse/system.pa

cd kodi-a2dp
zip -r service.osmc.btplayer.zip service.osmc.btplayer/
cd -

## mobile internet
apt install ppp wvdial

cat << EOF > /etc/wvdial.conf

[Dialer Defaults]
Modem = /dev/ttyUSB0
Baud = 921600
Init = ATZ
Init1 = AT+CGDCONT=1,"IP","gprs.swisscom.ch"
Init2 = AT+CGATT=1
Dial Command = ATD
Phone = *99***1#
Password = gprs
Username = gprs

EOF

echo "defaultroute" >> /etc/ppp/peers/wvdial

cp ppp/ppp0 /etc/network/interfaces.d/
