#!/bin/bash
case $ALBERT_OP in
  "METADATA")
    STDOUT='{
      "iid":"org.albert.extension.external/v2.0",
      "name":"Goldendict",
      "version":"1.0",
      "author":"Manuel Schneider",
      "dependencies":["goldendict"],
      "trigger":"gd "
    }'
    echo -n "${STDOUT}"
    exit 0
    ;;
  "INITIALIZE")
    hash goldendict 2>/dev/null && exit 0 || exit 1
    ;;
  "QUERY")
    QUERYSTRING="${ALBERT_QUERY:3}"
    echo -n '{
      "items":[{
        "id":"goldendict",
        "name":"Use goldendict to lookup '"'${QUERYSTRING}'"'",
        "description":"Opens the scan popup and searches for '"'${QUERYSTRING}'"'.",
        "icon":"goldendict",
        "actions":[{
          "name":"goldendict",
          "command":"goldendict",
          "arguments":["'${QUERYSTRING}'"]
        }]
      }]
    }'
    exit 0
    ;;
esac
