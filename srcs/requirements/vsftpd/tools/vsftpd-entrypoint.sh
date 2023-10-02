#!/bin/sh

set -e

#ln -sf /dev/stdout /var/log/vsftpd/vsftpd.log

exec "$@"
