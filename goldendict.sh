#!/bin/bash

case $ALBERT_OP in
    "METADATA")
        echo '{
            "iid":"org.albert.extension.external/v3.0",
            "name":"Goldendict",
            "version":"1.0",
            "author":"Manuel Schneider",
            "dependencies":["goldendict"],
            "trigger":"gd "
        }'
    ;;
    "INITIALIZE")
        hash goldendict 2>/dev/null || exit 1
    ;;
    "QUERY")
        echo -n '{
            "items":[{
                "id":"goldendict",
                "name":"Use goldendict to lookup '"'${ALBERT_QUERY}'"'",
                "description":"Opens the scan popup and searches for '"'${ALBERT_QUERY}'"'.",
                "icon":"goldendict",
                "actions":[{
                    "name":"goldendict",
                    "command":"goldendict",
                    "arguments":["'${ALBERT_QUERY}'"]
                }]
            }]
        }'
    ;;
esac
