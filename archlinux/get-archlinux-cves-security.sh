#!/usr/bin/env bash

rm -f all

wget -q https://security.archlinux.org/issues/all

grep CVE all | awk -F"\"" '{print $2",https://security.archlinux.org"$2}' | sed 's/^\///' | sort -n | uniq > archlinux-cve-security.csv

