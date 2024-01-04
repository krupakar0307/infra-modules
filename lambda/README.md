### Lambda Module

This is a module to provision lambda

## Usage

```sh 


provider "aws" {
    region = "ap-south-1"
}

module "lambda" {
    source          = "git::https://github.com/krupakar0307/infra-modules.git//lambda"
    lambda_role_name = "lambda_role_name" ##Provide name for your role.
    region          = "ap-south-1"
    runtime         = "python3.11"
    function_name   = "lambda-test"
    filename        = "lambda.py"
    handler         = "index.handler"
    environment_vars = {
        "kru" = "pakar"
        "reddy" = "yasa"
    }
}



```

##### Place you lamnda.py code file in root directory where you executing this module.

- Provide all input varables such file name of your code, function handler, runtime etc.