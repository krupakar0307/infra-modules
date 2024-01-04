variable "aws_profile" {
  description = "provide your environment profile"
  type        = string
}
variable "aws_region" {
  description = "provide your aws region"
  type        = string
}

variable "iam_role_name" {
  description = "provide name for your iam to create for s3 csi access for bucket"
  type        = string
}
variable "bucket_name" {
  description = "provide s3 bucket name that you wanna mount"
  type        = string
}
variable "eks_cluster" {
  type        = string
  description = "provide eks cluster name to provision s3 csi with your cluster"
}