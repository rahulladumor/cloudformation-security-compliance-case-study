#!/bin/bash

echo "🗑️  Cleaning up Security Stack"
echo "=============================="

STACK_NAME="enterprise-security-stack"
REGION="us-east-1"

read -p "⚠️  Delete all security infrastructure? (yes/no): " -r
if [[ ! $REPLY =~ ^yes$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "🗑️  Deleting stack..."
aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
    --region $REGION

echo "⏳ Waiting for deletion..."
aws cloudformation wait stack-delete-complete \
    --stack-name $STACK_NAME \
    --region $REGION

echo ""
echo "✅ Stack deleted successfully!"
