1. GCP account/project: Create 'gcp-workshop-project'

2. Create a service account with the following roles and export json key
    Artifact Registry Administrator
    Compute Admin
    Kubernetes Engine Admin
    Kubernetes Engine Cluster Admin
    Service Account User
    Service Usage Admin

3. (Important. If you are using a Google VM, stop it, go to EDIT > "Access Scopes" and activate "Allow full access to all Cloud APIs")

    Initialize a system vars:
    ``
    export TF_VAR_gcp_project_id="gcp-workshop-project"
    export TF_VAR_gcp_region="us-central1" # We are using a zone instead of a region in this case
    TF_VAR_gcp_zone="us-central1-a
    ``

4. Upload json key and rename it to srvaccountkey.json. File must be into the same folder as the scripts

5. Execute terraform script
``
terraform init & terraform apply --auto-approve
`` 
