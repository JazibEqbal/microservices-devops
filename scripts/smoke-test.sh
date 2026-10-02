#!/bin/bash

set -e

if [ -z "$API_URL" ]; then
    echo "API_URL is not set."
    echo "Example:"
    echo "API_URL=http://localhost:8000 ./scripts/smoke-test.sh"
    exit 1
fi

echo "Testing API..."
curl --fail "$API_URL/"

echo
echo "Testing Message Service through API..."
curl --fail "$API_URL/message"

echo
echo "Testing Food Service through API..."
curl --fail "$API_URL/food"

echo
echo "All smoke tests passed."