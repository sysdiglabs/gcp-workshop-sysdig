#!/bin/bash

# install kubectl 1.27
echo "-- Install kubectl"
sudo apt-get update
sudo apt-get -y install kubectl google-cloud-sdk-gke-gcloud-auth-plugin

# Set gcloud scope
echo "-- GCloud auth"
gcloud auth activate-service-account --project=$TF_VAR_gcp_project_id --key-file=srvaccountkey.json
gcloud auth activate-service-account --key-file=srvaccountkey.json
gcloud auth login --cred-file=srvaccountkey.json --quiet
echo "-- GCloud set project"
gcloud config set project $TF_VAR_gcp_project_id --quiet
#gcloud auth application-default login --scopes openid,https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/iam --quiet

# configure kubectl
# gcloud container clusteres get-credentials gkeworkshopk8s --region $TF_VAR_region
echo "-- GCloud Auth container clusters"
k8sauthcmd="gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name) --zone $(terraform output zone) --project $(terraform output project_id)"
eval $k8sauthcmd

# Kubectl shell completion
cat << EOF > /root/.kube/completion.bash.inc
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
EOF

echo 'source /root/.kube/completion.bash.inc' >> /root/.bashrc

# Move kubeconfig to .kube folder
mv 

# falco event generator 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
kubectl create ns event-generator
helm upgrade --install event-generator falcosecurity/event-generator \
  --namespace event-generator \
  --create-namespace \
  --set config.loop=true \
  --set config.sleep=1m

# Kubectl deploy event-generator
 k create deployment playground --image=sysdiglabs/security-playground
