#!/usr/bin/env python3

"""
Wrapper for GNU units.
https://www.gnu.org/software/units/manual/units.html
Check /usr/share/units/definitions.units for unit definitions.
"""

import os
import sys
import json
import shutil
import subprocess


def metadata():
    print(json.dumps({
        "iid": "org.albert.extension.external/v3.0",
        "name": "Units",
        "version": "1.0",
        "author": "Manuel Schneider",
        "dependencies": ["units", "xclip"],
        "trigger": "units ",
        "description": "Unit converter for almost all popular units.",
        "usage_example": "units 1mach mph"
    }))


def intialize():
    if shutil.which("units") is None:
        print("'units' is not in $PATH.")
        sys.exit(1)


def query(string):
    args = string.split()
    if len(args) <= 2:
        item = {
            "description": "Result of 'units -t %s'" % string,
            "icon": "unknown",
        }
        try:
            result = subprocess.check_output(['units', '-t'] + args, stderr=subprocess.STDOUT).decode('utf-8').strip()
            item["actions"] = [{
                "name": "Copy to clipboard",
                "command": "sh",
                "arguments": ["-c", "echo -n '%s' | xclip -i -selection clipboard;" % (result)]
            }]
        except subprocess.CalledProcessError as e:
            result = e.stdout.decode('utf-8').strip().partition('\n')[0]
        item["name"] = result
        print(json.dumps({"items": [item]}))
    else:
        print(json.dumps({
            "items": [{
                "name": "Too many arguments",
                "description": "Units takes one or two arguments.",
                "icon": "unknown",
            }]
        }))


op = os.environ["ALBERT_OP"]
if op == "METADATA":
    metadata()
elif op == "INITIALIZE":
    intialize()
elif op == "QUERY":
    query(os.environ["ALBERT_QUERY"])
