#!/bin/bash

set -e

API_URL="${1:-http://api.local}"

echo "Running smoke test against: $API_URL"

echo "Checking API..."
curl --fail --silent --show-error \
    "$API_URL/"

echo
echo "Checking API -> Message Service..."
curl --fail --silent --show-error \
    "$API_URL/message"

echo
echo "Checking API -> Food Service..."
curl --fail --silent --show-error \
    "$API_URL/food"

echo
echo "Smoke test passed."