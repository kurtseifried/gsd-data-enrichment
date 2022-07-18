#!/bin/bash

# run from gsd-database directory

../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/amazon-linux/amazon-linux-cve-mainlist-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/archlinux/archlinux-cve-security-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/debian/debian-cve-crossreferences-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/mageia/mageia-cve-advisories-LASTONE.csv
#../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/oracle-linux/oracle-linux-cve-advisories-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/redhat/redhat-cve-rhsamapcpe-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/suse/suse-cve-mainlist-LASTONE.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/ubuntu/ubuntu-cve-oval-LASTONE.csv

