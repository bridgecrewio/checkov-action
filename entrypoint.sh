#!/bin/sh -l
echo "running checkov on directory: $1"
checkov -d $1 --check $2 --skip-check $3
