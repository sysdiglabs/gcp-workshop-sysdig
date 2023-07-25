#!/bin/bash

# install kubectl 1.27
curl -O curl -LO https://dl.k8s.io/release/v1.27.0/bin/linux/arm64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# download and deploy GKE cluster from Hashicorp demo https://github.com/hashicorp/learn-terraform-provision-gke-cluster
# git clone https://github.com/hashicorp/learn-terraform-provision-gke-cluster
cd learn-terraform-provision-gke-cluster

# configure kubectl
gcloud container clusteres get-credentials gkeworkshopk8s --region $GCP_REGION

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
