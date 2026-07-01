#!/usr/bin/env bash
# Scaffold new cloud infrastructure with Terraform
# Usage: ./new-cloud-infra.sh [project_name] [provider]

PROJECT_NAME="${1:-.}"
PROVIDER="${2:-aws}"

if [[ "$PROJECT_NAME" == "." ]]; then
    PROJECT_NAME=$(basename "$PWD")
fi

echo "☁️  Creating cloud infrastructure: $PROJECT_NAME ($PROVIDER)"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{terraform,scripts}
mkdir -p "$PROJECT_NAME/terraform"/{modules,envs}

# Create main.tf
cat > "$PROJECT_NAME/terraform/main.tf" << 'EOF'
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}
EOF

# Create variables.tf
cat > "$PROJECT_NAME/terraform/variables.tf" << 'EOF'
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "PROJECT_NAME_HERE"
}
EOF

# Create outputs.tf
cat > "$PROJECT_NAME/terraform/outputs.tf" << 'EOF'
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "environment" {
  description = "Environment"
  value       = var.environment
}
EOF

# Create .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
# Terraform
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc

# IDE
.vscode/
.idea/

# OS
.DS_Store
.env
EOF

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Cloud Infrastructure - $PROJECT_NAME

Terraform configuration for $PROVIDER infrastructure.

## Quick Start

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Destroy

```bash
cd terraform
terraform destroy
```
EOF

echo "✓ Cloud infrastructure created at: $PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME/terraform"
echo "  terraform init"
echo "  terraform plan"
