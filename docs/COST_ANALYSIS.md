# 💰 Cost Analysis

## Monthly Breakdown

| Service | Cost |
|---------|------|
| RDS Multi-AZ | $25 |
| NAT Gateway | $33 |
| AWS Config | $6 |
| CloudTrail | $0 |
| WAF | $5 |
| KMS | $2 |
| Other | $5 |
| **Total** | **$76** |

## Optimization Strategies

1. Use smaller RDS (t3.micro → db.t4g.micro) - Save $3/month
2. Reduce Config rule count - Save $2/month
3. WAF only for prod - Save $5/month (dev)

## Cost by Environment

- Development: $45/month
- Staging: $60/month
- Production: $76/month

See [README](../README.md) for details.
