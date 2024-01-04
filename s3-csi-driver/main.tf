resource "aws_eks_addon" "eks_s3_csi" {
  cluster_name                = data.aws_eks_cluster.eks_cluster.id
  addon_name                  = "aws-mountpoint-s3-csi-driver"
  addon_version               = data.aws_eks_addon_version.s3_csi_driver.version
  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn    = aws_iam_role.s3_eks_role.arn
}
