# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-06-28

This is the initial release that modernizes the Amazon EKS Cluster deployment configurations to support Terraform 1.0+ and AWS provider v4.x.

### Added
- **GitHub Actions Validation Workflow**: Configured `.github/workflows/validate.yml` to automatically validate the Terraform syntax using version `1.5.7`.

### Fixed
- **Missing wait_for_cluster and locals**: Resolved critical syntax errors in `outputs.tf` by export values directly from `module.eks` output, removing the legacy `data.http.wait_for_cluster` and undeclared local variables.
- **Legacy Variables Naming**: Renamed the variable `region-common` containing hyphens to `region_common` in `variables.tf`, `provider.tf`, and `cluster.tf` to prevent warnings.
- **Provider Deprecation Warnings**: Pinned the `kubernetes` provider version to `~> 2.10.0` in `versions.tf` to silence resource deprecation warnings from the EKS submodule.
- **VPC EIP compatibility**: Pinned the `aws` provider to `~> 4.57` in `versions.tf` to guarantee full compatibility with EKS module v19 and VPC module v1.0.0.

### Modernized
- **VPC Module Version**: Updated the AWS VPC submodule reference in `cluster.tf` to point to the modern and fixed `module-tf-aws-vpc.git` repository with tag `v1.0.0`.
- **EKS Module Version**: Upgraded the EKS module reference to the official registry `terraform-aws-modules/eks/aws` version `19.21.0` with updated `subnet_ids` and `eks_managed_node_groups` syntax.
- **Decoupled Versions**: Created a dedicated `versions.tf` file declaring modern Terraform and AWS Provider constraints.
