resource "aws_vpc" "EKS_vpc" {
  cidr_block = "172.32.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Django_EKS_VPC"
  }
}
