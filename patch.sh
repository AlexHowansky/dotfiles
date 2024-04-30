#!/bin/bash

REQUIRED="3.11.0"
INSTALLED=$(python --version | cut -d' ' -f2)
SMALLER=$(echo -e "${INSTALLED}\n${REQUIRED}" | sort -V | head -1)

if [ "${SMALLER}" == "${REQUIRED}" ]
then
    echo "You have Python >= 3.11.0, patching"
	patch -d powerline-shell -N -p1 < powerline-shell.patch
else
    echo "You have Python < 3.11.0, skipping patch"
fi
