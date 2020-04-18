#!/bin/sh -l
echo "Directory contents:"
ls -la
echo "We will now run Checkov."
checkov -d .
