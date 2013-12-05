#!/bin/sh

echo `date` >> /tmp/udev.log
echo "UDEV mount $@" >> /tmp/udev.log

mountpoint=/media/$1
if [ -d $mountpoint ]; then
  [ "$(ls -A $mountpoint)"	] && logger "$mountpoint is already used" && exit 1
else
  mkdir -p $mountpoint
fi
options="-o rw,nosuid,noatime"
case "$2" in 
	'vfat')
	  options="$options,nodev,noauto,noexec,dmask=000,fmask=111,utf8"
	;;
	'ntfs')
	  options="$options,nodev,noauto,noexec,dmask=000,fmask=111,utf8"
	;;
esac
/bin/mount -t $2 $options /dev/$1 $mountpoint

xinitstr="$(ps -ef|grep X|grep -w xinit)"
user=`echo $xinitstr|awk '{print $1}'`

echo "xinitstr=[$xinitstr]" >> /tmp/udev.log
echo "user=[$user]" >> /tmp/udev.log
[ -n "$user" ] && (export DISPLAY=:0.0; su $user -c "notify-send '$mountpoint mounted'")
