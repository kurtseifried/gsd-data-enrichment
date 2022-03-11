#!/bin/bash

# Ubuntu OVAL data seems like the best bet

rm -rf *.oval.xml

#wget https://security-metadata.canonical.com/oval/com.ubuntu.jammy.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.impish.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.focal.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.bionic.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.xenial.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.trusty.usn.oval.xml.bz2

# EOL
#wget https://security-metadata.canonical.com/oval/com.ubuntu.artful.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.breezy.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.cosmic.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.dapper.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.disco.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.edgy.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.eoan.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.feisty.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.groovy.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.gutsy.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.hardy.usn.oval.xml.bz2
wget -q https://security-metadata.canonical.com/oval/com.ubuntu.hirsute.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.hoary.usn.oval.xml.bz2
##wget https://security-metadata.canonical.com/oval/com.ubuntu.intrepid.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.jaunty.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.karmic.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.lucid.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.maverick.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.natty.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.oneiric.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.precise.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.quantal.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.raring.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.saucy.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.utopic.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.vivid.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.warty.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.wily.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.yakkety.usn.oval.xml.bz2
#wget https://security-metadata.canonical.com/oval/com.ubuntu.zesty.usn.oval.xml.bz2

bzip2 -d *.bz2

grep "https://ubuntu.com/security/CVE-" *.xml | cut -d"\"" -f4 | sort -n | uniq | awk -F" " '{print $1","$1}' | sed 's/https:\/\/ubuntu.com\/security\///' > ubuntu-cve-oval.csv

