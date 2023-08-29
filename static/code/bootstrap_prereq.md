1. GCP account: Create 'gcp-sysdig-workshop'
2. Create a service account with the following roles
    Artifact Registry Administrator
    Compute Admin
    Kubernetes Engine Admin
    Kubernetes Engine Cluster Admin
    Service Account User
    Service Usage Admin
3. Initialize a system var mamed GCP_PROJECT_ID with the name of the project (i.e. gcp-workshop-sysdig)
    ``
    export GCP_PROJECT_ID="gcp-project-name"
    ``
4. Upload json key and rename it to gcpsrvaccountkey.json. File must be into the same folder as the scripts
5. Launch general requirements
    ``
    bash ws_general_requirements.sh
    ``
6. Launch gke creator
    ``
    bash create_gke.sh
    ``
