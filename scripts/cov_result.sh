#!/bin/bash
rm coverage/run.json
rm coverage/run2.json
jq '(.. | select(type == "number" )) |= floor' coverage/.last_run.json >> coverage/run.json
cat coverage/run.json | jq '.result .line' >> coverage/run2.json
cover=`cat coverage/run2.json`
if [[ $cover < 80 ]]; then
    echo "COVERAGE MUY BAJO $cover"
    exit 42
fi
echo "COVERAGE ACEPTABLE $cover"