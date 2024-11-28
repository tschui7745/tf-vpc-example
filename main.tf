data "aws_availability_zones" "available" {
  state = "available"
}

 output "aws_availability_zones" {
 value = data.aws_availability_zones.available.names
 }

module "vpc" {
 source  = "terraform-aws-modules/vpc/aws"

 name = "tschui-example-vpc"
 cidr = "10.0.0.0/16"

 azs             = data.aws_availability_zones.available.names
 #azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
 private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
 public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

 enable_nat_gateway   = false
# enable_nat_gateway   = true
 single_nat_gateway   = true
 enable_dns_hostnames = true

 tags = {
  Terraform = "true"
 }
}

 output "nat_gateway_ids" {
 value = module.vpc.natgw_ids
}

 output "private_subnets" {
 value = module.vpc.private_subnets
}
