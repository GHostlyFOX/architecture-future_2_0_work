# ============================================
# Project Configuration Variables
# ============================================

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "future-2-0"
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "eu-central-1"
}

# ============================================
# Network Configuration Variables
# ============================================

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_app_cidr" {
  description = "CIDR block for private application subnet"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_subnet_data_cidr" {
  description = "CIDR block for private data subnet"
  type        = string
  default     = "10.0.20.0/24"
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # In production, restrict to specific IPs
}

# ============================================
# EC2 Instance Type Variables
# ============================================

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
  validation {
    condition     = can(regex("^t3\\.(micro|small|medium)$", var.bastion_instance_type))
    error_message = "Bastion instance type must be t3.micro, t3.small, or t3.medium"
  }
}

variable "app_instance_type" {
  description = "Instance type for application servers"
  type        = string
  default     = "t3.medium"
  validation {
    condition     = can(regex("^t3\\.(small|medium|large)$", var.app_instance_type))
    error_message = "App instance type must be t3.small, t3.medium, or t3.large"
  }
}

variable "db_instance_type" {
  description = "Instance type for database server"
  type        = string
  default     = "t3.large"
  validation {
    condition     = can(regex("^t3\\.(medium|large|xlarge)$", var.db_instance_type))
    error_message = "Database instance type must be t3.medium, t3.large, or t3.xlarge"
  }
}

variable "kafka_instance_type" {
  description = "Instance type for Kafka nodes"
  type        = string
  default     = "t3.large"
  validation {
    condition     = can(regex("^t3\\.(medium|large|xlarge|2xlarge)$", var.kafka_instance_type))
    error_message = "Kafka instance type must be t3.medium, t3.large, t3.xlarge, or t3.2xlarge"
  }
}

variable "airflow_instance_type" {
  description = "Instance type for Airflow server"
  type        = string
  default     = "t3.xlarge"
  validation {
    condition     = can(regex("^t3\\.(large|xlarge|2xlarge)$", var.airflow_instance_type))
    error_message = "Airflow instance type must be t3.large, t3.xlarge, or t3.2xlarge"
  }
}

variable "monitoring_instance_type" {
  description = "Instance type for monitoring server"
  type        = string
  default     = "t3.medium"
  validation {
    condition     = can(regex("^t3\\.(small|medium|large)$", var.monitoring_instance_type))
    error_message = "Monitoring instance type must be t3.small, t3.medium, or t3.large"
  }
}

# ============================================
# Storage Configuration Variables
# ============================================

variable "app_disk_size" {
  description = "Root disk size for application servers (GB)"
  type        = number
  default     = 50
  validation {
    condition     = var.app_disk_size >= 20 && var.app_disk_size <= 500
    error_message = "App disk size must be between 20 and 500 GB"
  }
}

variable "db_disk_size" {
  description = "Root disk size for database server (GB)"
  type        = number
  default     = 100
  validation {
    condition     = var.db_disk_size >= 50 && var.db_disk_size <= 1000
    error_message = "Database disk size must be between 50 and 1000 GB"
  }
}

variable "kafka_disk_size" {
  description = "Root disk size for Kafka nodes (GB)"
  type        = number
  default     = 100
  validation {
    condition     = var.kafka_disk_size >= 50 && var.kafka_disk_size <= 1000
    error_message = "Kafka disk size must be between 50 and 1000 GB"
  }
}

variable "airflow_disk_size" {
  description = "Root disk size for Airflow server (GB)"
  type        = number
  default     = 100
  validation {
    condition     = var.airflow_disk_size >= 50 && var.airflow_disk_size <= 500
    error_message = "Airflow disk size must be between 50 and 500 GB"
  }
}

variable "monitoring_disk_size" {
  description = "Root disk size for monitoring server (GB)"
  type        = number
  default     = 50
  validation {
    condition     = var.monitoring_disk_size >= 30 && var.monitoring_disk_size <= 200
    error_message = "Monitoring disk size must be between 30 and 200 GB"
  }
}

# ============================================
# Cluster Configuration Variables
# ============================================

variable "kafka_node_count" {
  description = "Number of Kafka nodes in the cluster"
  type        = number
  default     = 3
  validation {
    condition     = var.kafka_node_count >= 3 && var.kafka_node_count <= 7
    error_message = "Kafka node count must be between 3 and 7 for high availability"
  }
}

# ============================================
# SSH Key Configuration
# ============================================

variable "key_name" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string
  default     = "future-2-0-key"
}

# ============================================
# Load Balancer Configuration
# ============================================

variable "enable_alb_deletion_protection" {
  description = "Enable deletion protection for Application Load Balancer"
  type        = bool
  default     = false
}

variable "alb_health_check_path" {
  description = "Health check path for ALB target group"
  type        = string
  default     = "/health"
}

variable "alb_health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
  validation {
    condition     = var.alb_health_check_interval >= 5 && var.alb_health_check_interval <= 300
    error_message = "Health check interval must be between 5 and 300 seconds"
  }
}

# ============================================
# Tags Configuration
# ============================================

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# ============================================
# Cost Optimization Variables
# ============================================

variable "enable_instance_monitoring" {
  description = "Enable detailed CloudWatch monitoring for EC2 instances (additional cost)"
  type        = bool
  default     = false
}

variable "enable_ebs_encryption" {
  description = "Enable EBS encryption for all volumes"
  type        = bool
  default     = true
}

# ============================================
# Backup and Recovery Configuration
# ============================================

variable "enable_automated_backups" {
  description = "Enable automated EBS snapshots"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 35
    error_message = "Backup retention must be between 1 and 35 days"
  }
}

