1. GCP account/project: Create 'gcp-workshop-project'

2. Create a service account with the following roles and export json key
    Artifact Registry Administrator
    Compute Admin
    Kubernetes Engine Admin
    Kubernetes Engine Cluster Admin
    Service Account User
    Service Usage Admin

3. (Important. If you are using a Google VM, stop it, go to EDIT > "Access Scopes" and activate "Allow full access to all Cloud APIs")

    Initialize a system var mamed TF_GCP_PROJECT_ID and TF_GCP_REGION (i.e. gcp-workshop-sysdig)
    ``
    export TF_VAR_gcp_project_id="gcp-workshop-project"
    export TF_VAR_gcp_region="us-central1"
    export TF_VAR_gcp_zone="us-central1-b"
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
