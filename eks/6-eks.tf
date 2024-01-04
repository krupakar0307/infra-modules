###
# To create eks with in VPC, first we need VPC setup, where our EKS nodes will
# sit on Private Nodes, and load-balancers (inter-facing) will sit on public subnets.
#Now to Create EKS, we need eks policy (assumeRole), AmazonEKSClusterPolicy Policy attach to role.

#Once Role is created, attach it eks during cluster provision (line ~29)
####
resource "aws_iam_role" "eks-role" {
  name = "eks-${var.Environment}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-clusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-role.name
}

resource "aws_eks_cluster" "eks" {
  name = var.eks_name
  version = var.cluster_version
  role_arn = aws_iam_role.eks-role.arn
  enabled_cluster_log_types = ["api", "audit"]
  
  vpc_config {
    subnet_ids = concat(
      aws_subnet.private-subnets[*].id,
      aws_subnet.public-subnet[*].id
    )
    endpoint_private_access = true
    endpoint_public_access = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks-clusterPolicy
  ]
}

output "eks_subnets" {
  description = "EKS Provisioned SUbnets"
  value = aws_eks_cluster.eks.vpc_config[*].subnet_ids
}