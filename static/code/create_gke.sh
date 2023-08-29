#!/bin/bash

# install kubectl 1.27
curl -LO https://dl.k8s.io/release/v1.28.1/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# download and deploy GKE cluster from Hashicorp demo https://github.com/hashicorp/learn-terraform-provision-gke-cluster
# git clone https://github.com/hashicorp/learn-terraform-provision-gke-cluster
cd learn-terraform-provision-gke-cluster/

# find out or define gcp project id
if [[ -z "${GCP_PROJECT_ID}" ]]; then
  echo "export GCP_PROJECT_ID=$(gcloud config get-value project)"
fi
# find out or define gcp region
if [[ -z "${GCP_REGION}" ]]; then
  echo "export GCP_REGION=us-east1"
fi

# patch tf files
# change machine type
sed -ie 's/n1-standard-1/n1-standard-4/g' gke.tf
# change machine types for first instance type as well as the region
sed -ie 's/us-central1/us-east1/g' terraform.tfvars
# comment out terraform-cloud to set local terraform
sed -ie '6,10 s/^/#/' terraform.tf 

# deploy cluster
terraform init && terraform apply -auto-approve

# configure kubectl
# gcloud container clusteres get-credentials gkeworkshopk8s --region $GCP_REGION
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

# Kubectl shell completion
cat << EOF > /root/.kube/completion.bash.inc
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
EOF

echo 'source /root/.kube/completion.bash.inc' >> /root/.bashrc

# falco event generator 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
kubectl create ns event-generator
helm upgrade --install event-generator falcosecurity/event-generator \
  --namespace event-generator \
  --create-namespace \
  --set config.loop=true \
  --set config.actions=""
