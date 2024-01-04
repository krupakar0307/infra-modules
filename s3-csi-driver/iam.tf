resource "aws_iam_policy" "s3_eks_policy" {
  name        = "${var.bucket_name}-s3-mount-policy"
  description = "IAM policy for S3 bucket access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "MountpointFullBucketAccess",
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = ["arn:aws:s3:::${var.bucket_name}"],
      },
      {
        Sid    = "MountpointFullObjectAccess",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:AbortMultipartUpload",
          "s3:DeleteObject",
        ],
        Resource = ["arn:aws:s3:::${var.bucket_name}/*"],
      },
    ],
  })
}

resource "aws_iam_role" "s3_eks_role" {
  name = "${var.iam_role_name}-s3-mount-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.this.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:s3-csi-*",
            "${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:aud" = "sts.amazonaws.com",
          },
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "s3_eks_role_attachment" {
  policy_arn = aws_iam_policy.s3_eks_policy.arn
  role       = aws_iam_role.s3_eks_role.name
}