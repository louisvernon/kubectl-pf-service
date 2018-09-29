#!/bin/bash
if [ "$1" = "help" ]; then
  echo "args: service namespace port"
  exit 0
fi
set -ex
kubectl port-forward $1 --namespace $2 $(($3 + 1)):$3 &
sleep 5
socat tcp-listen:$3,fork tcp:127.0.0.1:$(($3 + 1))
