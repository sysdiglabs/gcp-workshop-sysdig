#!/bin/bash

# install kubectl 1.27
echo "Install kubectl"
curl -LO https://dl.k8s.io/release/v1.28.1/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# Instsall gcloud component for kubectl
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

# Set gcloud scope
echo "GCloud auth"
gcloud auth activate-service-account --project=$TF_VAR_gcp_project_id --key-file=srvaccountkey.json
gcloud auth activate-service-account --key-file=srvaccountkey.json
gcloud auth login --cred-file=srvaccountkey.json --quiet
echo "GCloud set project"
gcloud config set project $TF_VAR_gcp_project_id --quiet
#gcloud auth application-default login --scopes openid,https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/iam --quiet

# configure kubectl
# gcloud container clusteres get-credentials gkeworkshopk8s --region $TF_VAR_region
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
