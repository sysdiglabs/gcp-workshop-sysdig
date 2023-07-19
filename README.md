# Sysdig workshop for GCP

## Prerequisites

## Assets
- GCP Account
- Sysdig Acount
- Instructions: How to create a user with administration access

## Automations

- Install local tooling
  - Dependencies (jq gettext bash-completion moreutils)
  - gcloud CLI + delete previous credentials (in case) + configure credentials
  - kubectl
  - helm
- GKE
  - IaC provisioning
  - Deploy test workloads (helm)
  - Deploy Sysdig agents (helm)
- GCR
  - Create GCR registry, pull sample images and push them

## Content

- Introduction
- Install
  - Cloud
  - GKE
  - GCR
- Runtime threat detection
  - Cloud
  - GKE
- Vulnerability management
  - GKE Runtime insights
  - GCR scan

