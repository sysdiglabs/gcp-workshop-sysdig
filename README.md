# Sysdig workshop for GCP

## Prerequisites

## Launch workshop automations
Read static/code/bootstrap_prereq.md

## Assets
- GCP Account with administrator access
- Sysdig Acount

## Automations

Automations are located in the folder `static/code`

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

- [ ] Introduction
- [ ] Install
  - [ ] Cloud
  - [ ] GKE
  - [ ] GCR
- Runtime threat detection
  - [ ] Cloud
  - [ ] GKE
- Vulnerability management
  - [ ] GKE Runtime insights
  - [ ] GCR scan

