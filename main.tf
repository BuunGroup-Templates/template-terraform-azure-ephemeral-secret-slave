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

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault.name
  resource_group_name = var.key_vault.resource_group_name
}

ephemeral "azurerm_key_vault_secret" "this" {
  for_each     = var.secrets
  name         = each.value.name
  key_vault_id = data.azurerm_key_vault.key_vault.id
  version      = try(each.value.version, null)
} 