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

## Meta sources

* https://github.com/nexB/vulnerablecode/tree/main/vulnerabilities/importers


# Data enrichment sources and notes

The GSD currently pulls several data feeds in using a variety of automated and semi automated tools.

# broad feeds

## cve.org

* @joshbressers robot pulls this in daily
* contains reserved entries with no data even when they are public

## nvd.nist.gov

* @joshbressers robot pulls this in daily
* does not contain reserved entries, only contains CVE sourced data currently

## GHSA

## osv.dev

## GitLabs

## Packetstorm

## mend.io

# OSV Ecosystem specific

## Android
## crates.io (Rust)
## Debian

The official OSV schema specifies source packages only, the GSD also include binary packages

## GitHub Actions
## Go
## Hex (Erlang)
## Linux (Kernel)

The GSD has a semi automated vulnerbility from the Linux Kernel

## Maven
## npm
## NuGet
## OSS-Fuzz
## Packagist (PHP)
## Pub (Dart)
## PyPI
## RubyGems

# Other ecosystems

## Amazon Linux
## ArchLinux
## Mageia
## Oracle Linux
## Red Hat
## Rocky Linux
## SUSE
## Ubuntu
