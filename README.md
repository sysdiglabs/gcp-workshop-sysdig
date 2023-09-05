# Sysdig workshop for GCP

This workshop is designed to be hosted by qwiklabs
Target repo: https://github.com/CloudVLab/gcp-ce-content 
Lab: [ce070-a-hands-on-introduction-to-sysdig/](https://github.com/CloudVLab/gcp-ce-content/tree/main/labs/ce070-a-hands-on-introduction-to-sysdig)

## Launch workshop automations
Read static/code/bootstrap_prereq.md

## Assets
- GCP Account with administrator access
- Sysdig Acount

## Automations

Automations are located in the folder `static/code`

#### Sysdig
- [ ] Generate Sysdig accounts and assign to attendees

#### General 
- [x] Dependencies (jq gettext bash-completion moreutils)
- [x] gcloud CLI + delete previous credentials (in case) + configure credentials
- [x] kubectl
- [x] helm
#### GKE
- [x] IaC provisioning
- [x] Deploy test workloads (helm)
#### GCR
- [x] Create GCR registry, pull sample images and push them

## Content
Content is located in the folder `content`
