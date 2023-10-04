#!/bin/sh

set -e

#touch /var/log/vsftpd.log
#ln -sf /dev/stdout /var/log/vsftpd.log

exec "$@"
