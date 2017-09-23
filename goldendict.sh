#!/bin/bash
case $ALBERT_OP in
  "METADATA")
    STDOUT='{
      "iid":"org.albert.extension.external/v3.0",
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
    exit 0
    ;;
esac
