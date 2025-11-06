# 🏗️ Security Architecture - Enterprise Security & Compliance

## Design Principles

1. **Security by Default** - All resources encrypted, private by default
2. **Defense in Depth** - Multiple security layers
3. **Least Privilege** - Minimal IAM permissions
4. **Audit Everything** - Complete logging and monitoring
5. **Compliance First** - Built for regulatory requirements

## Architecture Layers

### Layer 1: Audit & Compliance
- **CloudTrail**: All API calls logged
- **AWS Config**: Continuous compliance monitoring
- **CloudWatch Logs**: Centralized logging

### Layer 2: Network Security
- **VPC**: Isolated network (10.0.0.0/16)
- **Private Subnets**: Database and Lambda isolated
- **Security Groups**: Minimal port access
- **NAT Gateway**: Controlled outbound access

### Layer 3: Data Protection
- **KMS Encryption**: All data at rest
- **TLS 1.2+**: All data in transit
- **S3 Block Public**: No public bucket access
- **RDS Encryption**: Database encrypted

### Layer 4: Access Control
- **IAM Roles**: No access keys
- **Secrets Manager**: Encrypted credentials
- **MFA Ready**: Can enable for sensitive ops

### Layer 5: Application Security
- **WAF**: Protection against common threats
- **CloudFront**: DDoS protection
- **HTTPS Only**: TLS termination

## Key Security Decisions

### Why Multi-AZ RDS?
- **HA**: Survives AZ failure
- **Compliance**: Required for SOC 2
- **Backup**: Automatic failover

### Why Private Subnets?
- **Security**: No direct internet access
- **Compliance**: HIPAA requirement
- **Defense**: Additional layer

### Why KMS vs S3-SSE?
- **Control**: Custom key policies
- **Audit**: CloudTrail integration
- **Compliance**: Most regulations require KMS

## Compliance Mapping

| Standard | Requirements | Implementation |
|----------|-------------|----------------|
| HIPAA | Encryption, Audit | KMS, CloudTrail |
| SOC 2 | Monitoring, Access | Config, IAM |
| PCI-DSS | Isolation, Logs | VPC, CloudWatch |
| GDPR | Protection, Trail | Encryption, Audit |

## Cost vs Security Trade-offs

Current: $76/month
- Optimal balance for enterprise
- Full compliance coverage
- Production-ready security

See [README](README.md) for full details.
