#!/bin/bash

# run from gsd-database directory

../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/amazon-linux/amazon-linux-cve-mainlist-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/archlinux/archlinux-cve-security-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/debian/debian-cve-crossreferences-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/mageia/mageia-cve-advisories-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/oracle-linux/oracle-linux-cve-advisories-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/redhat/redhat-cve-rhsamapcpe-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/suse/suse-cve-mainlist-CURRENT.csv
../gsd-data-enrichment/add-CVE-URL-CSV.sh ../gsd-data-enrichment/ubuntu/ubuntu-cve-oval-CURRENT.csv

