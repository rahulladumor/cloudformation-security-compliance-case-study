# Architecture Diagrams - Enterprise Security & Compliance

Comprehensive Mermaid diagrams for the Security & Compliance infrastructure.

## 1. Overall Security Architecture

```mermaid
graph TB
    subgraph External
        Users[Users/Auditors]
        Threat[Threat Actors]
    end
    
    subgraph AWS Cloud - Compliance Zone
        subgraph Security Services
            GD[AWS GuardDuty<br/>Threat Detection]
            SH[Security Hub<br/>Compliance Dashboard]
            CT[CloudTrail<br/>Audit Logging]
            Config[AWS Config<br/>Config Rules]
        end
        
        subgraph Monitoring & Alerting
            CW[CloudWatch Logs<br/>Centralized Logging]
            SNS[SNS Topics<br/>Security Alerts]
            Lambda[Lambda<br/>Auto-Remediation]
        end
        
        subgraph Data Protection
            KMS[AWS KMS<br/>Encryption Keys]
            SM[Secrets Manager<br/>Credentials]
            S3[S3 Buckets<br/>Encrypted Storage]
        end
        
        subgraph Network Security
            VPC[Private VPC<br/>No IGW]
            SG[Security Groups<br/>Least Privilege]
            NACL[Network ACLs<br/>Subnet Protection]
        end
        
        subgraph Compliance
            PCI[PCI-DSS Controls]
            HIPAA[HIPAA Controls]
            SOC2[SOC 2 Controls]
            GDPR[GDPR Controls]
        end
    end
    
    Users -->|Authenticated| CloudTrail
    Threat -.->|Blocked| GD
    
    GD -->|Findings| SH
    CT -->|Logs| CW
    Config -->|Compliance| SH
    
    SH -->|Alerts| SNS
    CW -->|Triggers| Lambda
    SNS -->|Notifications| Users
    
    Lambda -->|Remediate| Config
    
    KMS -->|Encrypt| S3
    SM -->|Protect| VPC
    VPC --> SG
    SG --> NACL
    
    SH --> PCI
    SH --> HIPAA
    SH --> SOC2
    SH --> GDPR
```

## 2. Compliance Framework

```mermaid
graph LR
    subgraph Compliance Standards
        PCI[PCI-DSS<br/>Payment Cards]
        HIPAA[HIPAA<br/>Healthcare]
        SOC2[SOC 2<br/>Trust Principles]
        GDPR[GDPR<br/>Data Privacy]
    end
    
    subgraph AWS Services Mapping
        CT[CloudTrail<br/>Audit Trail]
        Config[Config Rules<br/>Resource Compliance]
        KMS[KMS<br/>Encryption]
        GD[GuardDuty<br/>Threat Detection]
        SH[Security Hub<br/>Central Dashboard]
    end
    
    subgraph Controls
        AC[Access Control<br/>IAM Policies]
        ENC[Encryption<br/>At Rest & Transit]
        LOG[Logging<br/>All API Calls]
        MON[Monitoring<br/>Real-time Alerts]
    end
    
    PCI --> AC
    PCI --> ENC
    HIPAA --> ENC
    HIPAA --> LOG
    SOC2 --> MON
    SOC2 --> LOG
    GDPR --> ENC
    GDPR --> AC
    
    AC --> Config
    ENC --> KMS
    LOG --> CT
    MON --> GD
    
    CT --> SH
    Config --> SH
    KMS --> SH
    GD --> SH
```

## 3. GuardDuty Threat Detection Flow

```mermaid
sequenceDiagram
    participant Threat as Threat Actor
    participant VPC as VPC Flow Logs
    participant DNS as DNS Logs
    participant CT as CloudTrail
    participant GD as GuardDuty
    participant SH as Security Hub
    participant SNS as SNS Topic
    participant Admin as Security Admin
    participant Lambda as Auto-Remediation
    
    Threat->>VPC: 1. Suspicious Network Activity
    Threat->>DNS: 2. Malicious DNS Query
    Threat->>CT: 3. Unusual API Call
    
    VPC->>GD: 4. Analyze Traffic
    DNS->>GD: 5. Analyze DNS
    CT->>GD: 6. Analyze API Calls
    
    Note over GD: Machine Learning<br/>Threat Intelligence
    
    GD->>SH: 7. HIGH Severity Finding
    SH->>SNS: 8. Send Alert
    SNS->>Admin: 9. Email/SMS Alert
    SNS->>Lambda: 10. Trigger Auto-Response
    
    Lambda->>VPC: 11. Isolate Resource
    Lambda->>Admin: 12. Report Action Taken
```

## 4. Data Encryption Architecture

```mermaid
graph TB
    subgraph Data at Rest
        S3[S3 Buckets<br/>SSE-KMS]
        EBS[EBS Volumes<br/>KMS Encrypted]
        RDS[RDS Databases<br/>KMS Encrypted]
        DDB[DynamoDB Tables<br/>KMS Encrypted]
    end
    
    subgraph Encryption Keys
        CMK[Customer Master Key<br/>AWS KMS]
        DEK[Data Encryption Keys<br/>Auto-Rotated]
        Alias[Key Aliases<br/>compliance-key]
    end
    
    subgraph Data in Transit
        TLS[TLS 1.2+<br/>In-Flight Encryption]
        VPN[VPN Connections<br/>IPSec]
        PrivateLink[AWS PrivateLink<br/>Private Connectivity]
    end
    
    subgraph Key Management
        Rotation[Auto Rotation<br/>365 Days]
        Policy[Key Policy<br/>Least Privilege]
        Audit[Key Usage Logs<br/>CloudTrail]
    end
    
    CMK --> DEK
    CMK --> Alias
    
    DEK --> S3
    DEK --> EBS
    DEK --> RDS
    DEK --> DDB
    
    Rotation --> CMK
    Policy --> CMK
    CMK --> Audit
    
    TLS --> S3
    TLS --> RDS
    VPN --> VPC
    PrivateLink --> S3
```

## 5. CloudTrail Audit Flow

```mermaid
graph LR
    subgraph API Activity
        EC2API[EC2 API Calls]
        S3API[S3 API Calls]
        IAMAPI[IAM API Calls]
        KMSAPI[KMS API Calls]
    end
    
    subgraph CloudTrail
        Trail[Management Trail<br/>Multi-Region]
        DataTrail[Data Events Trail<br/>S3 Objects]
        InsightTrail[Insights<br/>Anomaly Detection]
    end
    
    subgraph Storage
        S3Bucket[S3 Bucket<br/>Encrypted<br/>Versioned<br/>MFA Delete]
        CWLogs[CloudWatch Logs<br/>Real-time Analysis]
    end
    
    subgraph Analysis
        Athena[Amazon Athena<br/>SQL Queries]
        QuickSight[QuickSight<br/>Dashboards]
        Lambda[Lambda<br/>Alert Processing]
    end
    
    EC2API --> Trail
    S3API --> DataTrail
    IAMAPI --> Trail
    KMSAPI --> Trail
    
    Trail --> S3Bucket
    DataTrail --> S3Bucket
    InsightTrail --> CWLogs
    
    S3Bucket --> Athena
    CWLogs --> Lambda
    Athena --> QuickSight
```

## 6. AWS Config Compliance Monitoring

```mermaid
graph TB
    subgraph AWS Resources
        EC2[EC2 Instances]
        S3B[S3 Buckets]
        IAM[IAM Roles]
        SG[Security Groups]
        RDS[RDS Instances]
    end
    
    subgraph Config Rules
        R1[encrypted-volumes<br/>EBS Encryption Required]
        R2[s3-bucket-public-read-prohibited<br/>No Public S3]
        R3[iam-password-policy<br/>Strong Passwords]
        R4[restricted-ssh<br/>No Open SSH]
        R5[rds-encryption-enabled<br/>RDS Encrypted]
    end
    
    subgraph Evaluation
        Config[AWS Config<br/>Continuous Evaluation]
        Results[Compliance Results<br/>COMPLIANT/NON_COMPLIANT]
    end
    
    subgraph Actions
        SNS[SNS Notification<br/>Non-Compliance Alert]
        Lambda[Auto-Remediation<br/>Lambda Function]
        SH[Security Hub<br/>Compliance Score]
    end
    
    EC2 --> Config
    S3B --> Config
    IAM --> Config
    SG --> Config
    RDS --> Config
    
    Config --> R1
    Config --> R2
    Config --> R3
    Config --> R4
    Config --> R5
    
    R1 --> Results
    R2 --> Results
    R3 --> Results
    R4 --> Results
    R5 --> Results
    
    Results -->|NON_COMPLIANT| SNS
    Results -->|NON_COMPLIANT| Lambda
    Results --> SH
```

## 7. Security Hub Integration

```mermaid
graph TB
    subgraph Security Services
        GD[GuardDuty<br/>Threat Detection]
        Config[AWS Config<br/>Compliance]
        Inspector[Amazon Inspector<br/>Vulnerability Scan]
        Macie[Amazon Macie<br/>Data Protection]
        IAMAccess[IAM Access Analyzer<br/>Permissions]
    end
    
    subgraph Security Hub
        Findings[Security Findings<br/>Aggregation]
        Standards[Compliance Standards<br/>CIS, PCI, AWS Best Practices]
        Insights[Security Insights<br/>Patterns & Trends]
        Score[Security Score<br/>0-100]
    end
    
    subgraph Actions
        EventBridge[EventBridge Rules<br/>Automated Responses]
        Lambda[Lambda Functions<br/>Remediation]
        SNS[SNS Topics<br/>Notifications]
        Tickets[ServiceNow/Jira<br/>Ticketing]
    end
    
    GD --> Findings
    Config --> Findings
    Inspector --> Findings
    Macie --> Findings
    IAMAccess --> Findings
    
    Findings --> Standards
    Findings --> Insights
    Standards --> Score
    
    Findings --> EventBridge
    EventBridge --> Lambda
    EventBridge --> SNS
    EventBridge --> Tickets
```

## 8. Incident Response Workflow

```mermaid
sequenceDiagram
    participant Threat as Security Threat
    participant GD as GuardDuty
    participant SH as Security Hub
    participant EB as EventBridge
    participant Lambda as Auto-Response
    participant SNS as SNS
    participant Team as Security Team
    participant Forensics as Forensics Tools
    
    Threat->>GD: 1. Malicious Activity Detected
    GD->>SH: 2. Create Finding (HIGH)
    SH->>EB: 3. Trigger Event
    
    par Automated Response
        EB->>Lambda: 4a. Execute Quarantine
        Lambda->>EC2: 5a. Isolate Instance
        Lambda->>SG: 6a. Block All Traffic
    and Manual Alert
        EB->>SNS: 4b. Send Alert
        SNS->>Team: 5b. Page On-Call
    end
    
    Team->>Forensics: 7. Initiate Investigation
    Forensics->>CloudTrail: 8. Analyze Logs
    Forensics->>VPC: 9. Capture Traffic
    
    Team->>Lambda: 10. Approve Permanent Fix
    Lambda->>SH: 11. Close Finding
    Team->>SNS: 12. Post-Mortem Report
```

## 9. Network Security Layers

```mermaid
graph TB
    subgraph Internet
        Attack[Attack Vector]
    end
    
    subgraph Layer 1 - Perimeter
        WAF[AWS WAF<br/>SQL Injection Protection<br/>XSS Protection]
        Shield[AWS Shield<br/>DDoS Protection]
    end
    
    subgraph Layer 2 - Network
        VPC[Private VPC<br/>No Internet Gateway]
        NACL[Network ACLs<br/>Subnet Level]
        SG[Security Groups<br/>Instance Level]
    end
    
    subgraph Layer 3 - Application
        IAM[IAM Policies<br/>Least Privilege]
        MFA[MFA Required<br/>Privileged Actions]
        Secrets[Secrets Manager<br/>No Hardcoded Credentials]
    end
    
    subgraph Layer 4 - Data
        KMS[KMS Encryption<br/>All Data Encrypted]
        Block[Block Public Access<br/>S3 & RDS]
        Versioning[Versioning & Backups<br/>Data Retention]
    end
    
    subgraph Layer 5 - Monitoring
        CT[CloudTrail<br/>API Logging]
        GD[GuardDuty<br/>Threat Detection]
        Config[Config Rules<br/>Compliance]
    end
    
    Attack -.->|Blocked| WAF
    Attack -.->|Blocked| Shield
    WAF -->|Pass| NACL
    Shield -->|Pass| NACL
    
    NACL --> SG
    SG --> IAM
    IAM --> MFA
    MFA --> Secrets
    
    Secrets --> KMS
    KMS --> Block
    Block --> Versioning
    
    NACL --> CT
    SG --> GD
    IAM --> Config
```

## 10. Compliance Reporting Dashboard

```mermaid
pie title Compliance Score by Framework
    "PCI-DSS" : 95
    "HIPAA" : 98
    "SOC 2" : 92
    "GDPR" : 97
    "AWS Best Practices" : 94
```

```mermaid
graph LR
    subgraph Automated Reports
        Daily[Daily Reports<br/>Security Findings]
        Weekly[Weekly Reports<br/>Compliance Trends]
        Monthly[Monthly Reports<br/>Executive Summary]
        Audit[Audit Reports<br/>Full Evidence Package]
    end
    
    subgraph Data Sources
        SH[Security Hub]
        Config[AWS Config]
        CT[CloudTrail]
        CW[CloudWatch]
    end
    
    subgraph Delivery
        Email[Email<br/>PDF Reports]
        S3[S3 Bucket<br/>Report Archive]
        Portal[Web Portal<br/>Interactive Dashboard]
    end
    
    SH --> Daily
    SH --> Weekly
    Config --> Monthly
    CT --> Audit
    CW --> Daily
    
    Daily --> Email
    Weekly --> Email
    Monthly --> Portal
    Audit --> S3
```

---

## Diagram Legend

- **Solid Lines**: Active data flow
- **Dotted Lines**: Blocked/Failed attempts
- **GREEN**: Compliant/Secure
- **RED**: Non-compliant/Alert
- **YELLOW**: Warning/Review needed

---

## Key Security Features

### 1. Threat Detection
- GuardDuty: ML-powered threat detection
- Security Hub: Centralized findings
- CloudWatch: Real-time monitoring

### 2. Compliance
- AWS Config: Continuous compliance
- CloudTrail: Complete audit trail
- 4 major frameworks (PCI, HIPAA, SOC 2, GDPR)

### 3. Encryption
- KMS: Customer-managed keys
- All data encrypted at rest
- TLS 1.2+ for data in transit

### 4. Network Security
- Private VPC (no IGW)
- Security Groups (least privilege)
- Network ACLs (subnet protection)

### 5. Auto-Remediation
- Lambda functions for response
- EventBridge for orchestration
- SNS for notifications

---

**Author**: Rahul Ladumor  
**License**: MIT 2025
