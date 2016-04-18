#!/bin/sh
exec 2>&1
set -e

#  Starting the java process
exec  /usr/sbin/slapd -h ldap:/// ldaps:/// -g openldap -u openldap -f /etc/ldap/slapd.conf
