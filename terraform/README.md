## Setup for External State

- Copy the `.env.template` in a `.env` file.

- Set your `.env` file with a Personal Access Token from GitLab with the **API** permission and a personal vault token

- Export your secrets as env variables

```bash
source .env
```

- Initialize Terraform with setting the backend (not needed for the job-interview, just a preperation for the future)

```bash
terraform init -backend-config=init/$CLUSTER_NAME.tfbackend
```

- Modify the variable file of your ressource and check the modification planned by Terraform:

```bash
terraform plan -var-file=tfvars/$CLUSTER_NAME.tfvars
```

- Apply your modification:

```bash
terraform apply -var-file=tfvars/$CLUSTER_NAME.tfvars
```