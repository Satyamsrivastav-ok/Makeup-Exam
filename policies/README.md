# Project: Secure DevOps CI/CD & Governance Platform

## Overview
This project implements a complete DevOps lifecycle including automated infrastructure management, secure CI/CD pipelines, and policy-driven governance. The goal is to ensure that security (OPA) and quality (SonarQube) are integrated directly into the version control workflow.

## 1. System Administration & Infrastructure
The project environment is built on a structured Linux hierarchy with strict Access Control Lists (ACLs).

### Directory Architecture
- configs/: Core configuration files (deployment.yaml, pipeline.yaml, security.conf).
- deployments/: Active deployment manifests.
- policies/: Rego policy files for OPA validation.
- reports/: Storage for SonarQube and OPA security audits.
- artifacts/: Versioned build logs and deployment outputs.

### User & Permission Schema
- Groups: developers (Members: developer, tester), operations (Member: devopsadmin).
- Access Policy: devopsadmin has full sudo privileges for system maintenance. The developers group has read/write access limited to the project workspace to prevent unauthorized system-wide changes.

## 2. Version Control Strategy
We utilize a multi-branch Git workflow to ensure code quality before reaching production.

- main: The stable, production-ready source of truth.
- staging: Pre-release environment for Final Integration Testing.
- development: The primary branch for active feature work and daily commits.

Workflow Logic: Features are developed on development, validated via CI/CD, merged to staging for QA, and finally pushed to main for release.

## 3. Automation Pipeline (CI/CD)
The pipeline is triggered automatically on every push to the development branch.

Stages:
1. Source Checkout: Syncs the latest code from the repository.
2. Build/Environment Setup: Prepares the runtime and dependencies.
3. Security Gate (OPA): Runs Open Policy Agent to check manifests against security policies.
4. Quality Gate (SonarQube): Performs static analysis for bugs, vulnerabilities, and code smells.
5. Artifact Archival: Saves build logs and security reports into the artifacts/ and reports/ directories.

## 4. Security & Governance (Policy as Code)
Security is enforced using OPA (Open Policy Agent). The following rules are strictly enforced:
- Non-Root Execution: Deployments must not run as the root user.
- Privilege Escalation: Privileged container execution is blocked.
- Image Tagging: The use of the ':latest' tag is forbidden; specific version tags are required for traceability.

## 5. Maintenance & Disaster Recovery
- Backup: A scheduled task creates a timestamped, compressed archive of the entire configuration.
- Rollback: The Git history and CI/CD configuration allow for immediate reversion to previous stable states in case of deployment failure.

---
End of Documentation
