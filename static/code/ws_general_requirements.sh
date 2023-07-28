#!/bin/bash

# Uninstall gcloud cli
curl https://sdk.cloud.google.com > install.sh
bash install.sh --disable-prompts

# Install jq command-line tool for parsing JSON, and bash-completion
sudo yum -y install jq gettext bash-completion moreutils

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

# Set the ACCOUNT_ID and the region to work with our desired region
export GCP_REGION=us-east1
gcloud config set compute/region ${GCP_REGION}

# Configure .bash_profile
export GCP_PROJECT_ID=$(gcloud config get-value project)
echo "export GCP_PROJECT_ID=$GCP_PROJECT_ID" | tee -a ~/.bash_profile
echo "export GCP_PROJECT_NUMBER=$(gcloud projects describe $GCP_PROJECT_ID --format='value(projectNumber)')"
echo "export GCP_REGION=$GCP_REGION" | tee -a ~/.bash_profile

# Enable Google Services
gcloud services enable \
  cloudresourcemanager.googleapis.com \
  container.googleapis.com \
  artifactregistry.googleapis.com \
  containerregistry.googleapis.com \
  containerscanning.googleapis.com

# GCR Registry for module 2, create repository
export GCR_NAME=GCP-workshop

repositories=( "$ECR_NAME" "mysql" "postgres" "redis" )

for repo in ${repositories[@]}; do
    gcloud artifacts repositories create ${repo} --repository-format=docker \
    --location=$GCP_REGION \
    --description="Docker repository for Sysdig Workshop"
done

# auth CLI with registry
# configure auth
gcloud auth configure-docker $GCP_REGION-docker.pkg.dev

# populate Registry
repositories=( \
    "mysql:5.7" \
    "postgres:13" \
    "redis:6" \
)

for repo_src in ${repositories[@]}; do

    docker pull ${repo_src}

    repo_dest=${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT_ID}/${repo_src} 
    docker tag ${repo_src} ${repo_dest}
    docker push ${repo_dest}
done

   
# Validate that our IAM role is valid.
# ToDo
