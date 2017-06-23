#!/bin/bash

GREEN=`tput setaf 6`
NC=`tput sgr0`

bundle check
bundle_result=$?

if [[ $bundle_result -ne 0 ]]; then
  bundle install
fi

echo ""
echo "${GREEN}Running Bash bats tests.....${NC}"
echo ""
./test/top_ten_test.sh
echo ""
echo ""
echo "${GREEN}Running Ruby rspec tests.....${NC}"
echo ""
rspec test
