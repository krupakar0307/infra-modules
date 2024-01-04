resource "aws_iam_role" "nodes" {
  name = "eks-${var.Environment}-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "private-nodes-${var.Environment}"
  node_role_arn   = aws_iam_role.nodes.arn
  version = aws_eks_cluster.eks.version
  subnet_ids = concat(
    aws_subnet.private-subnets[*].id,
    aws_subnet.public-subnet[*].id
  )

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.large"]
  ami_type = "BOTTLEROCKET_x86_64"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }



  taint {
    key    = "team"
    value  = "devops"
    effect = "NO_SCHEDULE"
  }

#   launch_template {
#     name    = aws_launch_template.eks-node-amis.name
#     version = aws_launch_template.eks-node-amis.latest_version
#   }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}
resource "aws_eks_node_group" "private-nodes-2" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "private-nodes-${var.Environment}-2"
  node_role_arn   = aws_iam_role.nodes.arn
  version = aws_eks_cluster.eks.version
  subnet_ids = concat(
    aws_subnet.private-subnets[*].id,
    aws_subnet.public-subnet[*].id
  )
  capacity_type  = "SPOT"
  instance_types = ["t3.large"]
  ami_type = "BOTTLEROCKET_x86_64"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 0
  }

  update_config {
    max_unavailable = 2
  }


  taint {
    key    = "devs"
    value  = "devops-cloud"
    effect = "PREFER_NO_SCHEDULE"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

  # launch_template {
  #   name    = aws_launch_template.eks-node-amis.name
  #   version = aws_launch_template.eks-node-amis.latest_version
  # }

# resource "aws_launch_template" "eks-node-amis" {
#   name = "eks-with-bottlerocket"
#   image_id = "ami-083a4b47b26349164"
#   instance_type = "t3.micro"
#   # key_name = "local-provisioner"
# }
