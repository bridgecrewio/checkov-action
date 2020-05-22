#!/bin/bash
# Actions pass inputs as $INPUT_<input name> environmet variables
#
[[ ! -z "$INPUT_CHECK" ]] && CHECK_FLAG="--check $INPUT_CHECK"
[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
[[ ! -z "$INPUT_QUIET" ]] && QUIET_FLAG="--quiet"

matcher_path=`pwd`/checkov-problem-matcher.json

cp /usr/local/lib/checkov-problem-matcher.json "$matcher_path"

echo "::add-matcher::checkov-problem-matcher.json"
echo "running checkov on directory: $1"
checkov -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG
