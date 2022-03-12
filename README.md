# gsd-data-enrichment

gsd-data-enrichment. After some experimentation I've decided:

Shell scripts, they work, it's easy to follow what is going on. We'll also refactor this in Python 3 long term so we can support URL's with commas for example (a known problem right now).

## Updating CVE/URL data

Create a CSV file of CVE ID and a URL to add, e.g.:

```
CVE-2000-1234,https://somevendor/path/CVE-2000-1234
```

There is no header line. Each vendor has a unique way of presenting this data, some as a single page, some as multiple pages. We're focusing on single page ones for now. Each VENDOR will have a directory with a VENDOR shortname (e.g. debian, suse, redhat, fedora, microsoft, android). These directories will have a script with the VENDOR shortname and an optional SOURCENAME (some vendors have multiple overlapping sources) called "get-VENDOR-[SOURCENAME]-CVEs.sh" with an output of VENDOR-[SOURCENAME]-CVE.csv and VENDOR-[SOURCENAME]-CVE-LASTONE.csv (the previous copy of VENDOR-[SOURCENAME]-CVE.csv) and the diff of the two: VENDOR-[SOURCENAME]-CVE-CURRENT.csv

## Updating GSD files with the CVE/URL data

Take that CSV file and walk through it using the add-CVE-URL-CSV.sh script, check on GSD entries for the CVEs:

1. If one is found with the URL, great, ignore, we already have it.
2. If one is found with no URL, add the URL.
3. If no file is found create a stub file and add the URL. Please note that some vendors have errors/typos in their data, as we discover these we will clean up the files we have created. I have already contacted vendors about cleaning these up.

The stub file will be:

```
{
    "GSD": {
        "alias": "CVE-YEAR-INTEGER",
        "id": "GSD-YEAR-INTEGER",
        "references": [
            "https://VENDOR_LINK/HERE"
        ]
    }
}
```

Once we touch or create a JSON file we run it through the print-json.py to ensure the JSON isn't mangled and to fix the spacing (2 spaces, not 4).

We go against VENDOR-[SOURCENAME]-CVE-CURRENT.csv to speed things up.
