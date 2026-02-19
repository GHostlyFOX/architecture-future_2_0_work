# ============================================
# Network Outputs
# ============================================

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_app_subnet_id" {
  description = "ID of the private application subnet"
  value       = aws_subnet.private_app.id
}

output "private_data_subnet_id" {
  description = "ID of the private data subnet"
  value       = aws_subnet.private_data.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_gateway_public_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

# ============================================
# Security Group Outputs
# ============================================

output "security_group_web_id" {
  description = "ID of the web security group (ALB)"
  value       = aws_security_group.web.id
}

output "security_group_app_id" {
  description = "ID of the application security group"
  value       = aws_security_group.app.id
}

output "security_group_database_id" {
  description = "ID of the database security group"
  value       = aws_security_group.database.id
}

output "security_group_kafka_id" {
  description = "ID of the Kafka security group"
  value       = aws_security_group.kafka.id
}

output "security_group_bastion_id" {
  description = "ID of the bastion security group"
  value       = aws_security_group.ssh.id
}

# ============================================
# EC2 Instance Outputs
# ============================================

output "bastion_instance_id" {
  description = "Instance ID of the bastion host"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_ssh_command" {
  description = "SSH command to connect to bastion host"
  value       = "ssh -i ${var.key_name}.pem ec2-user@${aws_instance.bastion.public_ip}"
}

output "app_server_1_id" {
  description = "Instance ID of application server 1"
  value       = aws_instance.app_server_1.id
}

output "app_server_1_private_ip" {
  description = "Private IP address of application server 1"
  value       = aws_instance.app_server_1.private_ip
}

output "app_server_2_id" {
  description = "Instance ID of application server 2"
  value       = aws_instance.app_server_2.id
}

output "app_server_2_private_ip" {
  description = "Private IP address of application server 2"
  value       = aws_instance.app_server_2.private_ip
}

output "database_instance_id" {
  description = "Instance ID of the database server"
  value       = aws_instance.database.id
}

output "database_private_ip" {
  description = "Private IP address of the database server"
  value       = aws_instance.database.private_ip
}

output "kafka_instance_ids" {
  description = "Instance IDs of Kafka nodes"
  value       = aws_instance.kafka[*].id
}

output "kafka_private_ips" {
  description = "Private IP addresses of Kafka nodes"
  value       = aws_instance.kafka[*].private_ip
}

output "airflow_instance_id" {
  description = "Instance ID of the Airflow server"
  value       = aws_instance.airflow.id
}

output "airflow_private_ip" {
  description = "Private IP address of the Airflow server"
  value       = aws_instance.airflow.private_ip
}

output "monitoring_instance_id" {
  description = "Instance ID of the monitoring server"
  value       = aws_instance.monitoring.id
}

output "monitoring_private_ip" {
  description = "Private IP address of the monitoring server"
  value       = aws_instance.monitoring.private_ip
}

# ============================================
# Load Balancer Outputs
# ============================================

output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.main.id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "alb_url" {
  description = "URL to access the application through ALB"
  value       = "http://${aws_lb.main.dns_name}"
}

output "app_target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app.arn
}

# ============================================
# Infrastructure Summary
# ============================================

output "infrastructure_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    project_name    = var.project_name
    environment     = var.environment
    aws_region      = var.aws_region
    vpc_id          = aws_vpc.main.id
    bastion_ip      = aws_instance.bastion.public_ip
    alb_url         = "http://${aws_lb.main.dns_name}"
    app_servers     = [aws_instance.app_server_1.private_ip, aws_instance.app_server_2.private_ip]
    database_ip     = aws_instance.database.private_ip
    kafka_cluster   = aws_instance.kafka[*].private_ip
    airflow_ip      = aws_instance.airflow.private_ip
    monitoring_ip   = aws_instance.monitoring.private_ip
  }
}

# ============================================
# Connection Information
# ============================================

output "connection_instructions" {
  description = "Instructions for connecting to infrastructure"
  value = <<-EOT
    
    ========================================
    Infrastructure Deployment Complete
    ========================================
    
    1. Bastion Host Access:
       ssh -i ${var.key_name}.pem ec2-user@${aws_instance.bastion.public_ip}
    
    2. Application URL:
       ${aws_lb.main.dns_name}
    
    3. Connect to Private Instances:
       Use bastion as jump host:
       ssh -i ${var.key_name}.pem -J ec2-user@${aws_instance.bastion.public_ip} ec2-user@<private-ip>
    
    4. Application Servers:
       - App Server 1: ${aws_instance.app_server_1.private_ip}
       - App Server 2: ${aws_instance.app_server_2.private_ip}
    
    5. Database Server:
       - PostgreSQL: ${aws_instance.database.private_ip}:5432
    
    6. Kafka Cluster:
       - Nodes: ${join(", ", aws_instance.kafka[*].private_ip)}
    
    7. Airflow:
       - Web UI: ${aws_instance.airflow.private_ip}:8080
    
    8. Monitoring:
       - Grafana: ${aws_instance.monitoring.private_ip}:3000
       - Prometheus: ${aws_instance.monitoring.private_ip}:9090
    
    ========================================
    
  EOT
}

# ============================================
# Resource Tags
# ============================================

output "common_tags" {
  description = "Common tags applied to all resources"
  value = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Company     = "Future-2.0"
  }
}

