#!/bin/bash

echo "📁 Bootstrapping folder structure for DevOps Automation Engine..."

# Root-level folders
mkdir -p .github/workflows/infra
mkdir -p .github/workflows/test
mkdir -p blueprints/landing-zone/vpc
mkdir -p modules
mkdir -p scripts
mkdir -p apps/nodejs-app/src
mkdir -p apps/python-app/src
mkdir -p apps/java-app/src
mkdir -p apps/shared-templates

# Workflow files
echo 'name: Provision ECS Infra
on: [workflow_dispatch]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Placeholder
      run: echo "Provision ECS Infra"' > .github/workflows/infra/provision-ecs.yml

echo 'name: Provision VPC Infra
on: [workflow_dispatch]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Placeholder
      run: echo "Provision VPC Infra"' > .github/workflows/infra/provision-vpc.yml

echo 'name: OIDC Test
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - name: Test OIDC
      run: echo "Testing OIDC integration"' > .github/workflows/test/oidc-test.yml

# VPC Blueprint
echo '{
  "VpcCIDR": "10.0.0.0/16"
}' > blueprints/landing-zone/vpc/parameters.json

echo 'AWSTemplateFormatVersion: "2010-09-09"
Description: Sample VPC CloudFormation
Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: !Ref VpcCIDR
      Tags:
        - Key: Name
          Value: SampleVPC' > blueprints/landing-zone/vpc/vpc-stack.yaml

# Shared Template
echo 'name: App CI Template
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Build step
      run: echo "Run build logic here"' > apps/shared-templates/ci-template.yml

# App READMEs and Workflows
echo "# NodeJS App" > apps/nodejs-app/README.md
echo "# Python App" > apps/python-app/README.md
echo "# Java App" > apps/java-app/README.md

echo 'name: NodeJS App CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Node build
      run: echo "Build nodejs app"' > apps/nodejs-app/.github/workflows/ci.yml

echo 'name: Python App CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Python build
      run: echo "Build python app"' > apps/python-app/.github/workflows/ci.yml

echo 'name: Java App CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Java build
      run: echo "Build java app"' > apps/java-app/.github/workflows/ci.yml

# .gitignore
echo '# Node
node_modules/

# Python
__pycache__/
*.pyc

# Java
*.class
build/

# General
.env
.DS_Store' > .gitignore

# Root README
echo "# DevOps Automation Engine

This repository manages infrastructure, CI/CD pipelines, and application lifecycles using GitHub Actions and AWS." > README.md

echo "✅ Folder structure created successfully!"
