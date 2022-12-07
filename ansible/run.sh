# must run aws configure before, and install both ansible and kubectl
aws eks --region us-east-1 update-kubeconfig --name Sree_EKS_Cluster &&
ansible-playbook playbook.yml

