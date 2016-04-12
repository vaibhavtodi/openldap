#!/bin/sh
exec 2>&1
set -e

#  Starting the java process
exec  /usr/sbin/slapd -d  0 -h "ldap://0.0.0.0:389/ ldaps://0.0.0.0:636/"
