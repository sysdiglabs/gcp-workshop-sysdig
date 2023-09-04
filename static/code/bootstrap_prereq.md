1. GCP account/project: Create 'gcp-workshop-project'

2. Create a service account with the following roles and export json key
    Artifact Registry Administrator
    Compute Admin
    Kubernetes Engine Admin
    Kubernetes Engine Cluster Admin
    Service Account User
    Service Usage Admin

3. Initialize a system var mamed TF_GCP_PROJECT_ID and TF_GCP_REGION (i.e. gcp-workshop-sysdig)
    ``
    export TF_GCP_PROJECT_ID="gcp-workshop-project"
    export TF_GCP_REGION="us-central1"
    ``

4. Upload json key and rename it to srvaccountkey.json. File must be into the same folder as the scripts

5. Launch general requirements
    ``
    bash ws_general_requirements.sh
    ``

6. Launch gke creator
    ``
    bash create_gke.sh
    ``
