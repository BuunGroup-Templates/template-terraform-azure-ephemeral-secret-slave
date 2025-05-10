```bash
#################################################################
#     ____  __  ____  ___   __   __________  ____  __  ______   #
#    / __ )/ / / / / / / | / /  / ____/ __ \/ __ \/ / / / __ \  #
#   / __  / / / / / / /  |/ /  / / __/ /_/ / / / / / / / /_/ /  #
#  / /_/ / /_/ / /_/ / /|  /  / /_/ / _, _/ /_/ / /_/ / ____/   #
# /_____/\____/\____/_/ |_/   \____/_/ |_|\____/\____/_/        #
#                                                               #
#                                                               #
# Buun Group Pty Ltd.                                           #
# Copyright 2025 Buun Group Pty Ltd. All rights reserved.       #
# https://buungroup.com                                         #
#                                                               #
#################################################################

```

# template-terraform-azure-ephemeral-secret-slave

A focused, reusable Terraform module for reading ephemeral Azure Key Vault secrets.  
**This is a "slave" module:** it is designed to be imported and used by other modules or root configurations, not as a standalone deployment.

---

## What is this module?

This module provides a secure, DRY, and compliant way to fetch ephemeral secrets from Azure Key Vault using the new Terraform ephemeral resource pattern.  
It is intended to be used as a submodule ("slave") in your own modules or root configurations, so you can compose it with other resources as needed.

---

## Usage

### Prerequisites

- You must provide a GitHub Personal Access Token (PAT) for private module access. **Do not hardcode this in your code.**
- Set the token securely as an environment variable:

```sh
export TF_VAR_github_pat=your_personal_access_token_here
```

Terraform will automatically use this value for the `github_pat` variable.

---

### Minimal Example (Single Secret)

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

### Multiple Secrets Example

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

## Recommended Pattern

- **Import this module wherever you need ephemeral secrets.**
- **Do not embed ephemeral logic directly in your main modules.**  
  This keeps your code DRY, secure, and compliant with Terraform's ephemeral output rules.
- **Use outputs from this module** (`values`, `expiration_dates`, `not_before_dates`) as needed in your root module or other modules. These outputs are maps keyed by your `secrets` map keys.

---

## Inputs/Outputs

See [terraform-docs](https://github.com/terraform-docs/terraform-docs) output below for full details.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Key Vault configuration object. Must include name and resource\_group\_name. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of secrets to fetch from Key Vault | <pre>map(object({<br/>    name    = string<br/>    version = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

---

## Secure Usage in CI/CD

- Store your GitHub PAT as a secret in your CI/CD system (e.g., GitHub Actions, GitLab CI, Azure DevOps).
- Inject it as an environment variable (`TF_VAR_github_pat`) in your pipeline before running Terraform.
- Never commit secrets to version control.

---

## Testing

This module includes experimental integration tests using `terraform test`.  
See the `tests` directory for details and example configurations.

---

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 