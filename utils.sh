terraform_out() {
    cd aws_setup_jenkins/terraform

    terraform output -raw instance_public_ip
}

remote() {
    instance_ip=$(terraform_out)
    user=ubuntu

    ssh -i "jenkins_ssh_key.pem" $user@$instance_ip
}

playbook() {
    cd aws_setup_jenkins/ansible

    ansible-playbook -i inventory initialize.yml
}
