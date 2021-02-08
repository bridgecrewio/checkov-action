#!/bin/bash
# Actions pass inputs as $INPUT_<input name> environmet variables
#
[[ ! -z "$INPUT_CHECK" ]] && CHECK_FLAG="--check $INPUT_CHECK"
[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
[[ ! -z "$INPUT_QUIET" ]] && QUIET_FLAG="--quiet"
[[ ! -z "$INPUT_SOFT_FAIL" ]] && SOFT_FAIL_FLAG="--soft-fail"
[[ ! -z "$INPUT_FRAMEWORK" ]] && FRAMEWORK_FLAG="--framework $INPUT_FRAMEWORK"

EXTCHECK_DIRS_FLAG=""
if [ ! -z "$INPUT_EXTERNAL_CHECKS_DIRS" ]; then
  IFS=', ' read -r -a extchecks_dir <<< "$INPUT_EXTERNAL_CHECKS_DIRS"
  for d in "${extchecks_dir[@]}"
  do
    EXTCHECK_DIRS_FLAG="$EXTCHECK_DIRS_FLAG --external-checks-dir $d"
  done
fi

EXTCHECK_REPOS_FLAG=""
if [ ! -z "$INPUT_EXTERNAL_CHECKS_REPOS" ]; then
  IFS=', ' read -r -a extchecks_git <<< "$INPUT_EXTERNAL_CHECKS_REPOS"
  for repo in "${extchecks_git[@]}"
  do
    EXTCHECK_REPOS_FLAG="$EXTCHECK_REPOS_FLAG --external-checks-git $repo"
  done
fi

echo "input_soft_fail:$INPUT_SOFT_FAIL"
matcher_path=`pwd`/checkov-problem-matcher.json
if [ ! -z "$INPUT_SOFT_FAIL"]; then
    cp /usr/local/lib/checkov-problem-matcher.json "$matcher_path"
    else
    cp /usr/local/lib/checkov-problem-matcher-softfail.json "$matcher_path"
fi

echo "::add-matcher::checkov-problem-matcher.json"
echo "running checkov on directory: $1"
checkov -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG $FRAMEWORK_FLAG $EXTCHECK_DIRS_FLAG $EXTCHECK_REPOS_FLAG
