#!/usr/bin/env bash
# Usage: ./scripts/teardown.sh [region] [stack-name]
REGION="${1:-us-east-1}"
STACK="${2:-HA-Lab}"

read -rp "Delete stack '$STACK'? This is irreversible. (yes/no): " CONFIRM
[[ "$CONFIRM" == "yes" ]] || { echo "Aborted."; exit 0; }

aws cloudformation delete-stack --stack-name "$STACK" --region "$REGION"
echo "Waiting for deletion..."
aws cloudformation wait stack-delete-complete --stack-name "$STACK" --region "$REGION"
echo "Done."
