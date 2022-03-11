#!/bin/bash

# run from gsd-database directory

../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/archlinux/archlinux-cve-security.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/debian/debian-cve-crossreferences.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/mageia/mageia-cve-advisories.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/redhat/redhat-cve-rhsamapcpe.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/suse/suse-cve-mainlist.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/ubuntu/ubuntu-cve-oval.csv
