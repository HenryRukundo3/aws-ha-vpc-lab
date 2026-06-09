#!/usr/bin/env bash
# Usage: ./scripts/deploy.sh [region] [stack-name]
REGION="${1:-us-east-1}"
STACK="${2:-HA-Lab}"

echo "Validating template..."
aws cloudformation validate-template \
  --template-body file://cloudformation/vpc-infrastructure.yaml \
  --region "$REGION"

echo "Deploying stack: $STACK in $REGION ..."
aws cloudformation deploy \
  --stack-name "$STACK" \
  --template-file cloudformation/vpc-infrastructure.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$REGION"

echo "Stack outputs:"
aws cloudformation describe-stacks \
  --stack-name "$STACK" \
  --region "$REGION" \
  --query 'Stacks[0].Outputs[].[OutputKey,OutputValue]' \
  --output table
