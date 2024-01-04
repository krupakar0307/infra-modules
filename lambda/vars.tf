variable "lambda_role_name" {
    type = string
    # default = "my_lambda_test_role"
}
variable "region" {
    type = string
    # default = "ap-south-1"
}
variable "environment_vars" {
    type = map(string)
    # default = "Krupakar"
}
variable "runtime" {
    type = string
    # default = "python3.11"
}
variable "function_name" {
    type = string
    # default = "lambda_function_test"
}
variable "filename" {
    type = string
    # default = "lambda.py"
}
variable "handler" {
    type = string
    # default = "lambda.handler"
}