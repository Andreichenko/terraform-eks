# Amazon EKS Cluster Infrastructure Deployment

![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D%201.0.0-844FBA?logo=terraform)
![AWS Provider](https://img.shields.io/badge/AWS%20Provider-~%3E%204.57-FF9900?logo=amazon-aws)
![Kubernetes Provider](https://img.shields.io/badge/Kubernetes%20Provider-~%3E%202.10-326CE5?logo=kubernetes)
![CI/CD Validation](https://img.shields.io/github/actions/workflow/status/Andreichenko/terraform-eks/validate.yml?branch=master&label=CI%2FCD)

This repository contains the root Terraform configuration to deploy a fully-managed **Amazon Elastic Kubernetes Service (EKS)** cluster in AWS. The infrastructure is built on top of our custom AWS VPC module (`module-tf-aws-vpc`).

---

## 📐 EKS Cluster & Network Topology

The diagram below details how the root module composes the network layer and managed node group to deploy the EKS cluster:

```mermaid
graph TD
    subgraph AWS_Cloud ["☁️ AWS Cloud Platform"]
        subgraph VPC ["🌐 VPC Network (10.20.0.0/16)"]
            subgraph Subnets ["🔒 Private Subnets (us-east-1a, 1b, 1c)"]
                Node1["Worker Node 1 (t2.micro)"]
                Node2["Worker Node 2 (t2.micro)"]
                Node3["Worker Node 3 (t2.micro)"]
            end
        end

        subgraph EKS_Cluster ["☸️ Amazon EKS Control Plane"]
            MasterAPI["API Server (Kubernetes v1.28)"]
        end
    end

    VPC_Source["module.vpc"] -->|1. Provisions Network & subnets| VPC
    EKS_Source["module.eks"] -->|2. Creates Control Plane & Managed Node Groups| EKS_Cluster
    
    MasterAPI -->|"Manages Nodes"| Subnets
    Node1 & Node2 & Node3 -->|Join Cluster| EKS_Cluster
```

---

## 📂 Repository Structure

* **[cluster.tf](file://cluster.tf)**: Orchestrates the VPC creation using `module-tf-aws-vpc` (version `v1.0.0`) and EKS cluster creation using the official registry module (version `19.21.0`). Configures EKS Managed Node Group with auto-joining worker nodes (`t2.micro`).
* **[provider.tf](file://provider.tf)**: AWS provider setup. Region defaults to `var.region_common`.
* **[variables.tf](file://variables.tf)**: Configuration variables declarations (region, VPC CIDR, profile).
* **[versions.tf](file://versions.tf)**: Enforces required Terraform version (`>= 1.0`) and pins provider versions (`aws ~> 4.57` and `kubernetes ~> 2.10.0`) to avoid conflicts and deprecated warnings.
* **[outputs.tf](file://outputs.tf)**: Exports EKS cluster ID and ARN.

---

## 🚀 How to Run & Deploy

### 1. Configure AWS CLI Credentials
Ensure you have configured your local AWS CLI credentials profile:
```sh
aws configure
```

### 2. Initialize and Deploy
Initialize Terraform (downloads AWS and Kubernetes providers along with the referenced submodules):
```sh
terraform init
```
Generate and review deployment plan:
```sh
terraform plan
```
Apply and provision the EKS cluster (usually takes 10-15 minutes):
```sh
terraform apply
```

### 3. Connect to EKS Cluster
Once the cluster is successfully provisioned, configure local `kubectl` access:
```sh
aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster
```
Verify the worker nodes are ready:
```sh
kubectl get nodes
```

---

## 🛡️ CI/CD Validation
This repository has an active GitHub Actions workflow configured in `.github/workflows/validate.yml`. Upon every push to the `master` branch or pull requests, it automatically validates the configuration using Terraform version `1.5.7` to ensure syntax compliance and prevent deployment failures.
