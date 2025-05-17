
# 🌍 Grafana Infrastructure Deployment


This repository contains infrastructure as code (IaC) configurations using **Terraform**. The setup is environment-specific, with variables and backend configurations maintained per environment (e.g., `env-dev`).

---

## 📁 Project Structure

```


|── ansible/
│   ├── roles/grafana/tasks/main.yml      
│   └── playbook.yml 
├── env-dev/
│   ├── main.tfvars        # Environment-specific input variables
│   └── state.tfvars       # Backend config for storing state remotely (e.g., in S3)
├── modules/
│   ├──dns/
|   |    ├── main.tf       
│   |    └── variables.tf
│   ├──iam-rule/
|   |    ├── main.tf 
|   |    ├── output.tf       
│   |    └── variables.tf           
│   └── security-group/
|   |    ├── data.tf 
|   |    ├── main.tf 
|   |    ├── output.tf       
│   |    └── variables.tf
│   └── grafana/
|        ├── data.tf 
|        ├── main.tf 
|        ├── output.tf       
│        └── variables.tf  
├         
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md

```

---

## 🚀 Usage

Ensure you have:

- Terraform >= 1.0 installed
- Backend (e.g., S3, remote) properly configured
- Credentials (e.g., AWS) exported in your environment

Then run the following commands:

### 1. Initialize Terraform

Initializes the working directory and configures the backend:

```bash
cd grafana

terraform init -backend-config=env-dev/state.tfvars
```

### 2. Preview the Changes

Generates and shows an execution plan:

```bash
terraform plan -var-file=env-dev/main.tfvars
```

### 3. Apply the Infrastructure

Applies the changes required to reach the desired state:

```bash
terraform apply -var-file=env-dev/main.tfvars -auto-approve
```

---

## 🔐 Notes

* **State file** is stored remotely as per `state.tfvars` to enable collaboration and lock management.
* Always review the plan output before applying in production.
* Separate `.tfvars` files help manage multiple environments (`dev`, `staging`, `prod`).

---

## ✅ Best Practices

* Use remote state with locking (e.g., S3 + DynamoDB for AWS).
* Use workspaces or separate state files per environment.
* Store secrets securely (never in `*.tfvars` or VCS).

---

## 📄 License

MIT license.

