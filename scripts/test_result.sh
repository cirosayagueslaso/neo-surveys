#!/bin/bash
rm failed.json
rm pending.json
cat rspec.json | jq '.summary.failure_count' >> failed.json
cat rspec.json | jq '.summary.pending_count' >> pending.json
failed=`cat failed.json`
pending=`cat pending.json`
if [[ $failed > 0 ]]; then
    echo "HUBO PRUEBAS QUE FALLARON $failed"
    exit 42
fi

if [[ $pending > 0 ]]; then
    echo "HUBO PRUEBAS PENDIENTES $pending"
    exit 42
fi
echo "PRUEBAS ANDANDO"