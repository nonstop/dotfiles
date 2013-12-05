#!/bin/sh

echo `date` >> /tmp/udev.log
echo "UDEV umount $@" >> /tmp/udev.log

mountpoint=/media/$1
if [ -d $mountpoint ]; then
  /bin/umount /dev/$1 || exit 1
else
  logger "$mountpoint not found" && exit 1
fi

xinitstr="$(ps -ef|grep X|grep -w xinit)"
user=`echo $xinitstr|awk '{print $1}'`

echo "xinitstr=[$xinitstr]" >> /tmp/udev.log
echo "user=[$user]" >> /tmp/udev.log
[ -n "$user" ] && (export DISPLAY=:0.0; su $user -c "notify-send '$mountpoint unmounted'")
