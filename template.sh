#!/bin/bash

case $ALBERT_OP in
    "METADATA")
        echo '{
            "iid":"org.albert.extension.external/v3.0",
            "name":"Template",
            "version":"1.0",
            "author":"Manuel Schneider",
            "dependencies":[],
            "trigger":"template"
        }'
    ;;
    "INITIALIZE")
        exit 0
    ;;
    "FINALIZE")
        exit 0
    ;;
    "QUERY")
        echo '{
            "items":[{
                "name":"Item One",
                "description":"Item description containing the query: '"'${ALBERT_QUERY}'"'",
                "icon":"unknown",
                "actions":[{
                    "name":"Item action 1",
                    "command":"",
                    "arguments":[]
                },{
                    "name":"Secondary item action 1",
                    "command":"",
                    "arguments":[]
                }]
            },{
                "name":"Item two",
                "description":"Item description containing the query: '"'${ALBERT_QUERY}'"'",
                "icon":"unknown",
                "actions":[{
                    "name":"Item action 2",
                    "command":"",
                    "arguments":[]
                },{
                    "name":"Secondary item action 2",
                    "command":"",
                    "arguments":[]
                }]
            }]
        }'
    ;;
esac
