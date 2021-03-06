# /usr/local/sbin/nginx-mod-preinstall

#!/bin/bash
# Call NGINX module build scripts and pass error codes to apt hook

# Get NGINX version to upgrade to
read ngfile < <(grep '/nginx_') || exit 0
ngver=$(echo $ngfile | sed 's/-.*//' | sed 's/.*_//')

# List of build scripts to run:
/usr/local/sbin/mkbrotli $ngver || exit $?
# /usr/local/sbin/mkmodsec $ngver || exit $?
# /usr/local/sbin/mkpagespeed $ngver || exit $?
 
