#!/bin/bash

# Check Linux distro and version
echo "-- Linux version:"
cat /etc/os-release

# Is sudo installed? (debian)
echo "-- Install sudo (Debian)"
su -
apt-get -y install sudo

# Install gcloud cli
if which gcloud >/dev/null; then
  echo "gcloud already installed"
else
  sudo apt-get install apt-transport-https ca-certificates gnupg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  sudo apt-get update && sudo apt-get install google-cloud-cli
  sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  gcloud init
fi

# Install jq command-line tool for parsing JSON, and bash-completion
sudo apt-get update
sudo apt-get -y install jq gettext bash-completion moreutils 

# Install docker
curl -sSL https://get.docker.com/ | sudo sh

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh
rm ./get_helm.sh
# Verify the binaries are in the path and executable
for command in jq gcloud helm terraform
do
    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
done

# ToDo: Remove existing credentials if needed

# Authenticate gcloud CLI
# gcloud auth login # <- Not required as the prerequisite is to have a service-account initialized
echo "Setting ServiceAccount"
gcloud auth activate-service-account --project=$TF_VAR_gcp_project_id --key-file=srvaccountkey.json
gcloud auth activate-service-account --key-file=srvaccountkey.json
gcloud config set project $TF_VAR_gcp_project_id --quiet

# Configure Docker
echo "Configuring Docker"
gcloud auth configure-docker --quiet
sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker

# Set the ACCOUNT_ID and the region to work with our desired region
gcloud config set compute/region ${TF_VAR_gcp_region}

# Configure .bash_profile
echo "export GCP_PROJECT_ID=$TF_VAR_gcp_project_id" | tee -a ~/.bash_profile
echo "export GCP_PROJECT_NUMBER=$(gcloud projects describe $TF_VAR_gcp_project_id --format='value(projectNumber)')"
echo "export GCP_REGION=$TF_VAR_gcp_region" | tee -a ~/.bash_profile

# Enable Google Services
gcloud services enable \
  cloudresourcemanager.googleapis.com \
  container.googleapis.com \
  artifactregistry.googleapis.com \
  containerregistry.googleapis.com \
  containerscanning.googleapis.com

declare -a repositories
repositories=("mysql" "postgres" "redis" )

for repo in ${repositories[@]}; do
    gcloud artifacts repositories create ${repo} --repository-format=docker \
    --location=$TF_VAR_gcp_region \
    --description="Docker repository for Sysdig Workshop"
done

# auth CLI with registry
# configure auth
echo "Authenticating docker"
gcloud auth configure-docker $TF_VAR_gcp_region-docker.pkg.dev --quiet

# populate Registry
repoimages=( \
    "mysql:5.7" \
    "postgres:13" \
    "redis:6" \
)

for i in "${!repoimages[@]}"; do

    docker pull ${repoimages[i]}

    #wrong  docker push us-east1-docker.pkg.dev/mateo-burillo-ns/mysql:5.7
    #ok     docker push us-docker.pkg.dev/mateo-burillo-ns/manu-test-snyk/nginx:latest

    repo_dest=${TF_VAR_gcp_region}-docker.pkg.dev/${TF_VAR_gcp_project_id}/${repositories[i]}/${repoimages[i]}
    docker tag ${repoimages[i]} ${repo_dest}
    docker push ${repo_dest}
done

   
# Validate that our IAM role is valid.
# ToDo
