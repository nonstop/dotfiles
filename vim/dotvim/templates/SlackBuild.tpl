#!/bin/sh

# Slackware build script for <appname>

# Written by Evgeny Ratnikov (ratnikov dot ev at gmail dot com)

PRGNAM=appname
VERSION=${VERSION:-}
ARCH=${ARCH:-i486}
BUILD=${BUILD:-1}
TAG=${TAG:-_SBo}

CWD=$(pwd)
TMP=${TMP:-/tmp/$TAG}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

if [ "$ARCH" = "i486" ]; then
  SLKCFLAGS="-O2 -march=i486 -mtune=i686"
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
fi

set -e 

rm -rf $PKG
mkdir -p $TMP $PKG $OUTPUT
cd $TMP
rm -rf $PRGNAM-$VERSION
tar xvf $CWD/$PRGNAM-$VERSION.tar.gz
cd $PRGNAM-$VERSION
[ "$TEST_BUILD" ] || chown -R root:root .
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;

CFLAGS="$SLKCFLAGS" \
CXXFLAGS="$SLKCFLAGS" \
./configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --mandir=/usr/man

[ "$JOBS" ] && make -j$JOBS || make
make install DESTDIR=$PKG

# Strip binaries and libraries - this can be done with 'make install-strip'
# in many source trees, and that's usually acceptable if so, but if not, 
# use this:
( cd $PKG
  find . | xargs file | grep "executable" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null || true
  find . | xargs file | grep "shared object" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null
)

# Compress man pages
# If the man pages are installed to /usr/share/man instead, you'll need to either
# add the --mandir=/usr/man flag to configure or move them manually after the
# make install process is run.
( cd $PKG/usr/man
  find . -type f -exec gzip -9 {} \;
  for i in $( find . -type l ) ; do ln -s $( readlink $i ).gz $i.gz ; rm $i ; done
)

# Compress info pages and remove the package's dir file
# If no info pages are installed by the software, don't leave this in the script
rm -f $PKG/usr/info/dir
gzip -9 $PKG/usr/info/*.info*

# Remove perllocal.pod and other special files that don't need to be installed,
# as they will overwrite what's already on the system.  If this is not needed, 
# remove it from the script.
( cd $PKG
  # Remove 'special' files
  find . -name perllocal.pod \
    -o -name ".packlist" \
    -o -name "*.bs" \
    | xargs rm -f
)

mkdir -p $PKG/usr/doc/$PRGNAM-$VERSION
cp -a <documentation> $PKG/usr/doc/$PRGNAM-$VERSION
cat $CWD/$PRGNAM.SlackBuild > $PKG/usr/doc/$PRGNAM-$VERSION/$PRGNAM.SlackBuild
cat $CWD/slack-desc > $PKG/usr/doc/$PRGNAM-$VERSION/slack-desc

mkdir -p $PKG/install
cat $CWD/slack-desc > $PKG/install/slack-desc

cd $PKG
/sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.tgz