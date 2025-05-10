# Examples: template-terraform-azure-ephemeral-secret-slave

This folder contains usage examples for the ephemeral Key Vault secret slave module.

---

## Prerequisites

- You must provide a GitHub Personal Access Token (PAT) for private module access. **Do not hardcode this in your code.**
- Set the token securely as an environment variable:

```sh
export TF_VAR_github_pat=your_personal_access_token_here
```

Terraform will automatically use this value for the `github_pat` variable.

---

## Example: Fetch a Single Secret

```hcl
module "ephemeral_secret" {
  source = "git::https://${var.github_pat}@github.com/BuunGroup-Templates/template-terraform-azure-ephemeral-secret-slave.git//?ref=main"

  key_vault = {
    name                = "my-keyvault"
    resource_group_name = "my-resource-group"
  }

  secrets = {
    my_secret = {
      name         = "my-secret"
      key_vault_id = "<key-vault-id>"
      # version   = "optional-version"
    }
  }
}
```

---

## Example: Fetch Multiple Secrets

```hcl
module "ephemeral_secret" {
  source = "git::https://${var.github_pat}@github.com/BuunGroup-Templates/template-terraform-azure-ephemeral-secret-slave.git//?ref=main"

  key_vault = {
    name                = "my-keyvault"
    resource_group_name = "my-resource-group"
  }

  secrets = {
    db_password = {
      name         = "db-password"
      key_vault_id = "<key-vault-id>"
    }
    api_key = {
      name         = "api-key"
      key_vault_id = "<key-vault-id>"
      version      = "1.0.0"
    }
  }
}
```

---

## Outputs

- `values`: Map of all ephemeral Key Vault secret values, keyed by the secrets map keys (sensitive, ephemeral).
- `expiration_dates`: Map of all expiration dates, keyed by the secrets map keys (ephemeral).
- `not_before_dates`: Map of all not-before dates, keyed by the secrets map keys (ephemeral).

---

## Secure Usage in CI/CD

- Store your GitHub PAT as a secret in your CI/CD system (e.g., GitHub Actions, GitLab CI, Azure DevOps).
- Inject it as an environment variable (`TF_VAR_github_pat`) in your pipeline before running Terraform.
- Never commit secrets to version control. 