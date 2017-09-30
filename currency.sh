#!/bin/bash

case $ALBERT_OP in
    "METADATA")
        echo '{
            "iid":"org.albert.extension.external/v3.0",
            "name":"Currency converter",
            "version":"1.0",
            "author":"Manuel Schneider",
            "dependencies":[],
            "trigger":"exch ",
            "description": "Adapter for Google'\''s currency converter.",
            "usage_example": "exch 5 usd eur"
        }'
    ;;
    "QUERY")
        read -r -a fields <<< "${ALBERT_QUERY}"
        [ ${#fields[@]} -ne 3 ] && exit 0
        equation=`wget -qO- "https://finance.google.com/finance/converter?a=${fields[0]}&from=${fields[1]}&to=${fields[2]}"  | sed '/res/!d;s/<[^>]*>//g'`
        [ ${#equation} -le 2 ] && exit 0
        rhs=`echo $equation | cut -d ' ' -f4-`
        echo '{
            "items":[{
                "name":"'${rhs}'",
                "description":"'${equation}'",
                "icon":"accessories-calculator",
                "actions":[{
                    "name":"Copy to clipboard",
                    "command":"sh",
                    "arguments":["-c", "echo -n \"'"${rhs}"'\" | xclip -i -selection clipboard;"]
                }]
            }]
        }'
    ;;
esac
