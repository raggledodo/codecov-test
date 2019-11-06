#!/usr/bin/env bash

if [ $1 == "a" ]; then
    bazel coverage \
    --action_env="ASAN_OPTIONS=detect_leaks=0" \
    --config asan \
    --config cc_coverage //:a | grep -v '+' | grep -v 'Processing';
else
    bazel coverage \
    --action_env="ASAN_OPTIONS=detect_leaks=0" \
    --config asan \
    --config cc_coverage //:b | grep -v '+' | grep -v 'Processing';
fi

lcov --remove bazel-out/_coverage/_coverage_report.dat -o coverage.info;

if ! [ -z "$CODECOV_TOKEN" ];
then
    bash <(curl -s https://codecov.io/bash) -f coverage.info
fi
