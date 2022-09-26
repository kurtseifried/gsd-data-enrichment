#!/usr/bin/env python3

import os
import json
import re

# RUN FROM gsd-database/ - add a check for this?

cve_feed_json = "../gsd-data-enrichment/mozilla/cve-feed.json"

# Read the cve-feed.json
with open(cve_feed_json, 'r') as mozilla_json_file:
    mozilla_cve_data = json.load(mozilla_json_file)

def CVEID_toGSDfilepath(CVE_ID):
    elements = CVE_ID.split("-")
    year = elements[1]
    integer = elements[2]
    subdir = re.sub("[0-9][0-9][0-9]$", "xxx", integer)
    file_path = year + "/" + subdir + "/GSD-" + year + "-" + integer + ".json"
    return(file_path)

def set_file_indent(file):
    # This code breaks in 2030 and.or after we assign 1 million GSDs per year
    file_name = os.path.basename(file)
    # We match the years 2021 through 2029, 1 million and up so that's guaranteed GSD space only
    # GSD bot uses 2 space for indent
    # The CVE Bot uses the default 4 spaces, hence the need for checking
    # We can't simply read the file, check the second line and count spaces because
    # some workflows (e.g. data-enrichment for linux updates) involves using the command line jq which
    # indents to 4 spaces and appears to have no option for 2 spaces
    #
    if re.match("GSD-202[1-9]-1[0-9][0-9][0-9][0-9][0-9][0-9]", file):
        indent = 2
    else:
        indent = 4
    return(indent)

for entry in mozilla_cve_data:
    CVE_ID=entry["CVE_data_meta"]["ID"]
    # ignore the last broken one
    if CVE_ID == "CVE-2016-528":
        pass
    else:
        GSD_file_path = CVEID_toGSDfilepath(CVE_ID)
        # Check if file exists? if not write to the namespace, write the file and done
        # If exists read it in, add the mozilla.org key, write the file and done
        if os.path.exists(GSD_file_path):
            with open(GSD_file_path, 'r') as GSD_json_file:
                GSD_data = json.load(GSD_json_file)
                if 'namespaces' in GSD_data.keys():
                    GSD_data["namespaces"]["mozilla.org"] = entry
                else:
                    GSD_data["namespaces"] = {}
                    GSD_data["namespaces"]["mozilla.org"] = entry
            
            file_indent = set_file_indent(GSD_file_path)
            output = json.dumps(GSD_data, indent=file_indent)
            with open(GSD_file_path, "w") as f:
                f.write(output)
            print(GSD_file_path)
        else:
            GSD_data = {}
            GSD_data["namespaces"] = {}
            GSD_data["namespaces"]["mozilla.org"] = entry
            file_indent = set_file_indent(GSD_file_path)
            output = json.dumps(GSD_data, indent=file_indent)
            with open(GSD_file_path, "w") as f:
                f.write(output)
            print(GSD_file_path)

