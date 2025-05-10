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

output "values" {
  description = "Map of all ephemeral Key Vault secret values, keyed by the secrets map keys."
  value       = { for k, s in ephemeral.azurerm_key_vault_secret.this : k => s.value }
  sensitive   = true
  ephemeral   = true
}

output "expiration_dates" {
  description = "Map of all ephemeral Key Vault secret expiration dates, keyed by the secrets map keys."
  value       = { for k, s in ephemeral.azurerm_key_vault_secret.this : k => s.expiration_date }
  ephemeral   = true
}

output "not_before_dates" {
  description = "Map of all ephemeral Key Vault secret not_before_dates, keyed by the secrets map keys."
  value       = { for k, s in ephemeral.azurerm_key_vault_secret.this : k => s.not_before_date }
  ephemeral   = true
} 