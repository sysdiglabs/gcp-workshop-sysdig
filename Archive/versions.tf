# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.47.0"
    }
  }

  required_version = ">= 0.14"

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-kubernetes-engine:auth/v27.0.0"
  }
  
}

