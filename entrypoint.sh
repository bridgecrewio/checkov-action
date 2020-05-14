#!/bin/bash
# Actions pass inputs as $INPUT_<input name> environmet variables
#
[[ ! -z "$INPUT_CHECK" ]] && CHECK_FLAG="--check $INPUT_CHECK"
[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
echo "running checkov on directory: $1"
checkov -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG
