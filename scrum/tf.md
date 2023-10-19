Acceptance Criteria:

Terraform Upgrade (v1.50):

Terraform should be successfully upgraded to version 1.50 with no errors or deprecated code.
Independent Modules (VMSS & App Gateway):

Two separate Terraform modules must be created for Virtual Machine Scale Sets (VMSS) and Azure Application Gateway, with clearly defined input and output variables.
Orchestration Pipeline:

An orchestration pipeline should be established using a CI/CD tool (e.g., Azure DevOps or Jenkins) to coordinate the deployment of VMSS and App Gateway modules together, ensuring their dependencies are handled correctly.
GitLab Pipeline for Production:

A GitLab CI/CD pipeline must be implemented specifically for the production environment, with appropriate stages, jobs, and security measures, to ensure safe and controlled deployments of infrastructure changes.
All acceptance criteria should be met, and successful execution of these tasks must be validated through testing and documentation.
