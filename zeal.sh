#!/bin/bash

case $ALBERT_OP in
    "METADATA")
        echo '{
            "iid":"org.albert.extension.external/v3.0",
            "name":"Zeal",
            "version":"1.0",
            "author":"Manuel Schneider",
            "dependencies":["zeal"],
            "trigger":"zl ",
            "description": "Search docs using zeal.",
            "usage_example": "zl std::chrono"
        }'
    ;;
    "INITIALIZE")
        hash zeal 2>/dev/null || exit 1
    ;;
    "QUERY")
        echo '{
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
    ;;
esac
