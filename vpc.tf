resource "aws_vpc" "EKS_vpc" {
  cidr_block = "172.32.0.0/16"

  tags = {
    Name = "Django_EKS_VPC"
  }
}
