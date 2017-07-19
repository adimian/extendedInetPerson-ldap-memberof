#!/bin/bash
exec 1> >(logger -s -t $(basename $0)) 2>&1

set -eu

status () {
  echo "---> ${@}" >&2
}

# MEMBEROF
status "install memberOf overlay"
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /tmp/memberof_config.ldif
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint1.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint2.ldif

# EXTENDED
status "install extendedInetPerson schema"
ldapadd -Q -Y EXTERNAL -H ldapi:/// -c -f /tmp/extendedInetPerson.ldif


status "installation done"
