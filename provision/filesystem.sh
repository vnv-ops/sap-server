#!/bin/bash

set +e

# Maak correcte partities aan met fdisk
# Zie technische handleiding voor meer informatie
fdisk /dev/sda << _EOF_
    d
    2
    n
    p
    2


    n
    a
    2
    w
_EOF_

exit 0
