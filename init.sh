#!/bin/bash
set -e

terraform_apply() {
    echo "Apply aws infrastructure"
    terraform apply --auto-approve
}

run_ansible() {
    cd ../ansible
    ansible-playbook -i inventory initialize.yml
}

create_infra() {
    terraform_apply
    run_ansible
}

source ./aws_setup.sh
cd aws_setup_jenkins/terraform

if [ -d ".terraform" ]; then
    create_infra

else
    echo "First it needs to be initialized"
    terraform init
    create_infra
fi
