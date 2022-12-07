resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.EKS_vpc.id
  cidr_block        = "172.32.16.0/20"
  availability_zone = "us-east-1a"

  tags = {
    "Name"                                      = "private"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.EKS_vpc.id
  cidr_block              = "172.32.80.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

variable "cluster_name" {
default = "Sree_EKS_Cluster"
}
