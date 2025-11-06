# 🚀 Deployment Guide - Enterprise Security

## Prerequisites
- AWS CLI configured
- IAM admin permissions
- us-east-1 region access

## Deployment Steps

### Step 1: Validate
```bash
aws cloudformation validate-template \
  --template-body file://TapStack.yml \
  --region us-east-1
```

### Step 2: Deploy
```bash
aws cloudformation create-stack \
  --stack-name enterprise-security-stack \
  --template-body file://TapStack.yml \
  --capabilities CAPABILITY_IAM \
  --region us-east-1 \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=SecureApp \
    ParameterKey=Environment,ParameterValue=production
```

### Step 3: Monitor
```bash
aws cloudformation describe-stack-events \
  --stack-name enterprise-security-stack
```

### Step 4: Verify Security
```bash
# CloudTrail status
aws cloudtrail get-trail-status --name SecureApp-production-Trail

# Config status
aws configservice describe-configuration-recorders

# Check encryption
aws kms list-keys
```

## Post-Deployment

1. Enable MFA for IAM users
2. Review Config rules
3. Set up SNS alerts
4. Configure backup policies
5. Test WAF rules

## Troubleshooting

See [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

## Cleanup

```bash
./scripts/cleanup.sh
```
