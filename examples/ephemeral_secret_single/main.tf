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

module "ephemeral_secret_single" {
  source = "git::https://${var.github_pat}@github.com/BuunGroup-Templates/template-terraform-azure-ephemeral-secret-slave.git//?ref=main"

  key_vault = {
    name                = "my-keyvault"
    resource_group_name = "my-resource-group"
  }

  secrets = {
    my_secret = {
      name         = "my-secret"
      version      = "1.0.0"
    }
  }
}
