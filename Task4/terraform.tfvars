# ============================================
# Project Configuration
# ============================================
project_name = "future-2-0"
environment  = "production"
aws_region   = "eu-central-1"  # Frankfurt region for European customers

# ============================================
# Network Configuration
# ============================================
vpc_cidr                 = "10.0.0.0/16"
public_subnet_cidr       = "10.0.1.0/24"
private_subnet_app_cidr  = "10.0.10.0/24"
private_subnet_data_cidr = "10.0.20.0/24"

# Allow SSH only from specific IP ranges (example: office network)
# In production, replace with your actual office/VPN IP addresses
allowed_ssh_cidr = ["0.0.0.0/0"]  # CHANGE THIS IN PRODUCTION!

# ============================================
# EC2 Instance Types
# ============================================

# Bastion host - minimal resources needed for SSH gateway
bastion_instance_type = "t3.micro"

# Application servers - moderate compute for Docker containers
app_instance_type = "t3.medium"

# Database server - larger instance for PostgreSQL performance
db_instance_type = "t3.large"

# Kafka nodes - need good CPU and network throughput
kafka_instance_type = "t3.large"

# Airflow server - orchestration needs more resources
airflow_instance_type = "t3.xlarge"

# Monitoring - Grafana + Prometheus
monitoring_instance_type = "t3.medium"

# ============================================
# Storage Configuration (in GB)
# ============================================

# Application servers disk size
app_disk_size = 50

# Database server disk size
db_disk_size = 100

# Kafka nodes disk size
kafka_disk_size = 100

# Airflow server disk size
airflow_disk_size = 100

# Monitoring server disk size
monitoring_disk_size = 50

# ============================================
# Cluster Configuration
# ============================================

# Number of Kafka nodes (3 for HA, can scale to 5-7)
kafka_node_count = 3

# ============================================
# SSH Key Configuration
# ============================================

# SSH key pair name (must be created in AWS before running terraform)
# Create with: aws ec2 create-key-pair --key-name future-2-0-key --query 'KeyMaterial' --output text > future-2-0-key.pem
key_name = "future-2-0-key"

# ============================================
# Load Balancer Configuration
# ============================================

# Disable deletion protection for testing/development
enable_alb_deletion_protection = false

# Health check configuration
alb_health_check_path     = "/health"
alb_health_check_interval = 30

# ============================================
# Security and Compliance
# ============================================

# Enable EBS encryption for all volumes (compliance requirement)
enable_ebs_encryption = true

# Enable detailed monitoring (additional cost, useful for production)
enable_instance_monitoring = false  # Set to true for production

# ============================================
# Backup Configuration
# ============================================

# Enable automated backups
enable_automated_backups = true

# Retain backups for 7 days
backup_retention_days = 7

# ============================================
# Additional Tags
# ============================================

additional_tags = {
  CostCenter = "IT-Infrastructure"
  Owner      = "DevOps-Team"
  Compliance = "GDPR-Required"
  Backup     = "Enabled"
}

