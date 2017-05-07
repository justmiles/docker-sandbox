sudo apt-get install -y git gconf2 gconf-service libnotify4 gvfs-bin xdg-utils libxss1 libnspr4 libnss3 libnss3-nssdb

URL='https://atom.io/download/deb'
FILE=`mktemp`
wget "$URL" -qO $FILE
dpkg -i $FILE
rm -rf $FILE

# https://github.com/atom/atom/issues/4360
find /usr/lib -type f -name "libxcb.so.1*" -exec cp {} /usr/share/atom/libxcb.so.1 \;
sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/atom/libxcb.so.1
