#!/bin/sh

desc="basic xattr user namespace support"

dir=`dirname $0`
. ${dir}/../misc.sh

d0=`namegen`
n1=`namegen`
d1=`namegen`
n2=`namegen`

rm -rf ${d0}
#
# skip the test if xattrs are not implemented
#
mkdir ${d0}
if setfattr -n 'user.foo' ${d0} 2> /dev/null
then

rmdir ${d0}
echo "1..3"

# 1
expect 0 mkdir ${d0} 0777
expect 0 setxattr ${d0} "user.b" 'foo' c
expect 'foo' getxattr ${d0} user.b

#
# Clean
#
rm -rf ${d0}

else quick_exit_not_ok "xattrs unavailable"
fi
