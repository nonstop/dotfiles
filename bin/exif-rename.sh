#!/bin/sh

for f in $@; do
    datetime=`identify -verbose $f | grep "exif:DateTime\>" | cut -b20-`
    if [ -z "$datetime" ]; then
        datetime=`identify -verbose $f | grep "exif:DateTimeOriginal\>" | cut -b28-`
    fi
    f1=`echo $datetime|sed -s 's/\([0-9]\{4\}\):\([0-9]\{2\}\):\([0-9]\{2\}\) \([0-9]\{2\}\):\([0-9]\{2\}\):\([0-9]\{2\}\)/\1\2\3T\4\5\6.jpg/g'`
    if [ -f "$f1" ]; then
        echo "warning: File $f1 already exists, skipping $f."
    else
        mv $f $f1
        echo "$f => $f1"
    fi
done
