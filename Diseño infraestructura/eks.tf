module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "~> 19.0"
  cluster_name                    = "cloudapp-eks"
  cluster_version                 = "1.30"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_endpoint_public_access  = true # false para produccion
  cluster_endpoint_private_access = true
  cluster_addons = {

    coredns = {
      resolve_conflict = "OVERWRITE"
    }

    vpc-cni = {
      resolve_conflict = "OVERWRITE"
    }

    kube-proxy = {
      resolve_conflict = "OVERWRITE"
    }

    /*csi = {
      resolve_conflict = "OVERWRITE"
      version = "v1.35.0-eksbuild.1"
      most_recent = true
    }*/

  }

  manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    node_group = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t2.micro"]
      capacity_type  = "ON_DEMAND"
      subnets        = module.vpc.private_subnets
      tags = {
        Environment = "Cloud_App"
      }

    }
  }

  tags = {

    Terraform   = "true"
    Environment = "Cloud_App"

  }

}