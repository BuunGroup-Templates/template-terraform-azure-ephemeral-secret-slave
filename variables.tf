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

variable "key_vault" {
  description = "Key Vault configuration object. Must include name and resource_group_name."
  type = object({
    name                = string
    resource_group_name = string
  })
  validation {
    condition     = length(var.key_vault.name) > 0 && length(var.key_vault.resource_group_name) > 0
    error_message = "Both name and resource_group_name must be provided in the key_vault object."
  }
}

variable "secrets" {
  description = "Map of secrets to fetch from Key Vault"
  type = map(object({
    name         = string
    version      = optional(string)
  }))
  validation {
    condition     = length(var.secrets) > 0
    error_message = "At least one secret must be provided."
  }
}