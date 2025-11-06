#!/bin/bash
set -e

echo "🔐 Deploying Enterprise Security & Compliance Stack"
echo "===================================================="

STACK_NAME="enterprise-security-stack"
REGION="us-east-1"
TEMPLATE_FILE="../TapStack.yml"

# Prompt for project name
read -p "Enter project name (default: SecureApp): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-SecureApp}

read -p "Enter environment (dev/staging/prod): " ENVIRONMENT
ENVIRONMENT=${ENVIRONMENT:-prod}

echo ""
echo "🔍 Validating template..."
aws cloudformation validate-template \
    --template-body file://$TEMPLATE_FILE \
    --region $REGION > /dev/null

echo "✅ Template is valid"

echo ""
echo "📦 Creating secure stack..."
aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://$TEMPLATE_FILE \
    --capabilities CAPABILITY_IAM \
    --region $REGION \
    --parameters \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
        ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
    --tags \
        Key=Environment,Value=$ENVIRONMENT \
        Key=Project,Value=$PROJECT_NAME \
        Key=Security,Value=High \
        Key=Compliance,Value=Required

echo ""
echo "⏳ Waiting for stack creation (15-20 minutes)..."
aws cloudformation wait stack-create-complete \
    --stack-name $STACK_NAME \
    --region $REGION

echo ""
echo "✅ Stack created successfully!"
echo ""
echo "🔐 Security Features Enabled:"
echo "   ✓ CloudTrail logging"
echo "   ✓ AWS Config monitoring"
echo "   ✓ KMS encryption"
echo "   ✓ WAF protection"
echo "   ✓ Private subnets"
echo ""
echo "📊 Stack Outputs:"
aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --region $REGION \
    --query 'Stacks[0].Outputs[*].[OutputKey,OutputValue]' \
    --output table

echo ""
echo "🎉 Secure infrastructure deployed!"
