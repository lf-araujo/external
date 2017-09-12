#!/usr/bin/env python3

import os
import sys
import json
import shutil
import subprocess


def metadata():
    print(json.dumps({
        "iid": "org.albert.extension.external/v2.0",
        "name": "Units",
        "version": "1.0",
        "author": "Manuel Schneider",
        "dependencies": ["units"],
        "trigger": "units "
    }))


def intialize():
    if shutil.which("units") is None:
        print("'units' is not in $PATH.")
        sys.exit(1)


def query(string):
    split = string.split()
    if len(split) is 2:
        item = {
                "description": "Result of 'units -t %s'" % string,
                "icon": "unknown",
        }
        try:
            result = subprocess.check_output(['units', '-t'] + split).decode('utf-8').strip()
            item["actions"] = [{
                "name": "Copy to clipboard",
                "command": "sh",
                "arguments": ["-c", "echo -n '%s' | xclip -i; echo -n '%s' | xclip -i -selection clipboard;" % (result, result)]
            }]
        except subprocess.CalledProcessError as e:
            result = e.stdout.decode('utf-8').strip()
        item["name"] = result
        print(json.dumps({"items": [item]}))


op = os.environ["ALBERT_OP"]
if op == "METADATA":
    metadata()
elif op == "INITIALIZE":
    intialize()
elif op == "QUERY":
    query(os.environ["ALBERT_QUERY"][6:])
