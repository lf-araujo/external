#!/bin/bash

case $ALBERT_OP in
  "METADATA")
    METADATA='{
      "iid":"org.albert.extension.external/v3.0",
      "name":"Zeal",
      "version":"1.0",
      "author":"Manuel Schneider",
      "dependencies":["zeal"],
      "trigger":"zl ",
      "description": "Search docs using zeal.",
      "usage_example": "zl std::chrono"
    }'
    echo -n "${METADATA}"
    exit 0
    ;;
  "INITIALIZE")
    exit 0
    ;;
  "FINALIZE")
    exit 0
    ;;
  "QUERY")
    echo \
'{
  "items":[{
    "name":"Zeal",
    "description":"Lookup zeal docs.",
    "icon":"zeal",
    "actions":[{
      "name":"Lookup zeal docs",
      "command":"zeal",
      "arguments":["'"${ALBERT_QUERY}"'"]
    }]
  }]
}'
    exit 0
    ;;
esac
