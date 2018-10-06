#!/bin/bash

set +e

# Maak correcte partities aan met fdisk
  # `d` Start verwijderen partities.
  # `2` Verwijder dev/sda2.
  # `n` Creëer nieuwe partitie.
  # `p` Type primary.
  # `2` Partitienummer dev/sda2.
  # `/n` Vanaf de eerste sector.
  # `/n` Tot de laatst beschikbare sector
  # `n` Dit staat voor "Gelieve niet de signature van de partitie te verwijderen".
  # `a` Maak partitie bootable.
  # `2` Doe dit voor partitienummer 2.
  # `w` Dit schrijft alle changes naar de disk.

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
