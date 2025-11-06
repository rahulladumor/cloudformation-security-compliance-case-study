# 🚀 Quick Start - 5 Minute Secure Deploy

Deploy enterprise-grade security infrastructure in 5 minutes!

## Step 1: Deploy (1 minute)

```bash
aws cloudformation create-stack \
  --stack-name secure-stack \
  --template-body file://TapStack.yml \
  --capabilities CAPABILITY_IAM \
  --region us-east-1 \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=SecureApp \
    ParameterKey=Environment,ParameterValue=prod
```

## Step 2: Wait (15-20 minutes)

```bash
aws cloudformation wait stack-create-complete \
  --stack-name secure-stack \
  --region us-east-1
```

## Step 3: Verify Security

```bash
# Check CloudTrail is logging
aws cloudtrail get-trail-status --name SecureApp-prod-Trail

# Verify AWS Config is recording
aws configservice describe-configuration-recorders

# Check encryption
aws kms list-keys
```

## ✅ Done!

You now have:
- ✅ Complete audit trail (CloudTrail)
- ✅ Compliance monitoring (AWS Config)
- ✅ Encrypted database (RDS Multi-AZ)
- ✅ Secure networking (VPC + private subnets)
- ✅ WAF protection (CloudFront)
- ✅ Secret management (Secrets Manager)

**Cost**: ~$76/month

See [README](README.md) for full details.
