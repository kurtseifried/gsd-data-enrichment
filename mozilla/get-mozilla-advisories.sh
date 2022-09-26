#!/bin/bash

rm -f cve-feed.json
wget https://www.mozilla.org/en-US/security/advisories/cve-feed.json
../../gsd-tools/local-scripts/print-json.py ./cve-feed.json
