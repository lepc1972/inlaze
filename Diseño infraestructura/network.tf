module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "CloudApp"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  create_igw         = true
  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "Cloud_App"

  }




}