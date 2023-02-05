#!/bin/bash
set -e

source ./aws_setup.sh
cd aws_setup_jenkins/terraform

terraform_apply() {
    echo "apply aws infrastructure"
    terraform apply --auto-approve
}

if [ -d ".terraform" ]; then
    terraform_apply

else
    echo "it needs to initialize terraform"
    terraform init
    terraform_apply

fi
