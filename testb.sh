#!/usr/bin/env bash

bazel coverage \
--action_env="ASAN_OPTIONS=detect_leaks=0" \
--config asan \
--config cc_coverage //:b | grep -v '+' | grep -v 'Processing';

lcov --remove bazel-out/_coverage/_coverage_report.dat -o coverage.info;

if ! [ -z "$CODECOV_TOKEN" ];
then
    bash <(curl -s https://codecov.io/bash) -f coverage.info
fi
