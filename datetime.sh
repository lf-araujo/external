#!/bin/bash
# This extension shows the current date and time.
# To use this extension, type the trigger word "date" in Albert.

# The available actions copy
# - date in ISO format (e.g. 2017-09-10),
# - the full date and time (as displayed), or
# - a timestamp
# to the X clipboard. You can use Ctrl+V to paste it in other applications.
# I find the date and timestamp useful for naming files (amongst others use cases).

# Known problems:
# - If no action is executed and Albert shows up again, it still displays the
#   old time. Type "date" again to refresh.
# - Although the day name is localized by Albert's environment (environment
#   variables LANG or LC_*), the displayed date format is not.

# Why I added just these actions:
# - Date in ISO format: international standard, sorts nicely, useful for
#   filling out forms and naming files.
# - Full date and time: might be useful when you need the full date, day, time,
#   or parts thereof.
# - Timestamp with dashes: not readable without dashes; with colons in the
#   time, it would be unsuitable for filenames.
# - No "copy time only" action because I cannot think of a use case.

readonly FULL_DATE_FORMAT='%A, %d.%m.%Y, %H:%M'
readonly TIMESTAMP_FORMAT='%F-%H-%M-%S' # 2017-09-10-21-07-34

set -o errexit -o pipefail -o nounset

case $ALBERT_OP in
    "METADATA")
        echo '{
            "iid": "org.albert.extension.external/v3.0",
            "name": "DateTime",
            "version": "1.0",
            "author": "Jakob Schöttl",
            "dependencies": ["xclip"],
            "trigger": "date ",
            "description": "Copy current date and time to clipboard",
            "usage_example": "date"
        }'
    ;;
    "QUERY")
        declare fullDateTime isoDate daytime timestamp
        fullDateTime=$(date +"$FULL_DATE_FORMAT")
        isoDate=$(date -I)
        #daytime=$(date +'%H:%M')
        timestamp=$(date +"$TIMESTAMP_FORMAT")
        echo '{
            "items":[{
                "name":"'"$fullDateTime"'",
                "description":"Current date and time",
                "icon":"unknown",
                "actions":[{
                    "name":"Copy '"'$isoDate'"' to clipboard",
                    "command":"sh",
                    "arguments":["-c", "echo -n \"'"${isoDate}"'\" | xclip -i -selection clipboard;"]
                },{
                    "name":"Copy '"'$fullDateTime'"' to clipboard",
                    "command":"sh",
                    "arguments":["-c", "echo -n \"'"${fullDateTime}"'\" | xclip -i -selection clipboard;"]
                },{
                    "name":"Copy '"'$timestamp'"' to clipboard",
                    "command":"sh",
                    "arguments":["-c", "echo -n \"'"${timestamp}"'\" | xclip -i -selection clipboard;"]
                }]
            }]
        }'
    ;;
esac
