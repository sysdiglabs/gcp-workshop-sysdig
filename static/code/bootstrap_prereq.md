1. GCP account: Create 'gcp-sysdig-workshop' project and a service-account 
2. Upload json key and init gcloud service account
    ``
    gcloud auth activate-service-account --project=gcp-sysdig-workshop --key-file=gcpcmdlineuser.json
    gcloud auth activate-service-account --key-file=gcpcmdlineuser.json
    ``
3. Launch ws_general_requirements.sh
4. Launch create_gke.sh
