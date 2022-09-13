# Mozilla

https://www.mozilla.org/en-US/security/advisories/cve-feed.json

Run through print-json.py (8 megs to 12)

Write each entry to the GSD file namespace mozilla.org

Add support to the file converter to parse mozilla.org (in CVE JSON format) to GSD.
Add support to the schema validator to parse "cve-feed.json" as a list of CVE JSON entries.
