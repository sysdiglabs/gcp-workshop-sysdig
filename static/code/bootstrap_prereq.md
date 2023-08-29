1. GCP account: Create 'gcp-sysdig-workshop' project and a service-account 
2. Initialize a system var mamed GCP_PROJECT_ID with the name of the project (i.e. gcp-workshop-sysdig)
    ``
    export GCP_PROJECT_ID="gcp-project-name"
    ``
3. Upload json key and rename it to gcpsrvaccountkey.json). File must be into the same folder as the scripts
4. Launch ws_general_requirements.sh
5. Launch create_gke.sh
