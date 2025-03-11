#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

CLOUD_PROVIDER=${CLOUD_PROVIDER:-aws}

if [[ "$CLOUD_PROVIDER" == "azure" ]]; then
  if [[ -z "$ARM_SUBSCRIPTION_ID" || -z "$ARM_CLIENT_ID" || -z "$ARM_CLIENT_SECRET" || -z "$ARM_TENANT_ID" ]]; then
    logErrorMessage "Azure credentials are not set. Please provide ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, and ARM_TENANT_ID."
    exit 1
  fi
  export ARM_SUBSCRIPTION_ID
  export ARM_CLIENT_ID
  export ARM_CLIENT_SECRET
  export ARM_TENANT_ID
  logInfoMessage "Azure credentials exported successfully."
else
  logInfoMessage "Using AWS as default cloud provider."
fi

tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update terraform code available at [$tfCodeLocation]"

cd "${tfCodeLocation}" || { logErrorMessage "Failed to change directory to ${tfCodeLocation}"; exit 1; }

logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"

if [[ -n "$TF_MODULE_GIT_HOST_NAME" && -n "$TF_MODULE_GIT_USER" && -n "$TF_MODULE_GIT_PAT" ]]; then
  cat <<EOF > ~/.netrc
machine $TF_MODULE_GIT_HOST_NAME
    login $TF_MODULE_GIT_USER
    password $TF_MODULE_GIT_PAT
EOF
  chmod 600 ~/.netrc
  logInfoMessage "Generated ~/.netrc with credentials for $TF_MODULE_GIT_HOST_NAME."
else
  logInfoMessage "No GIT Credentials Provided. ~/.netrc will not be created."
fi

if [[ -z "$AUTH_METHOD" ]]; then
  logErrorMessage "AUTH_METHOD is not set."
  exit 1
fi

if [[ "$AUTH_METHOD" == "KEYS" ]]; then
  if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" ]]; then
    logErrorMessage "AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is not set."
    exit 1
  else
    logInfoMessage "Authentication via AWS Keys"
    export AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY
  fi
elif [[ "$AUTH_METHOD" == "ROLE" ]]; then
  if [[ -n "$ROLE_ARN" ]]; then
    assumeRole "$ROLE_ARN" "$SESSION_NAME"
  else
    logInfoMessage "ROLE_ARN is empty or not set. Using BuildPiper Server Credentials"
  fi
else
  logErrorMessage "AUTH_METHOD must be 'KEYS' or 'ROLE'."
  exit 1
fi

terraform init
case "$INSTRUCTION" in
  plan)
    terraform plan -var-file="terraform.tfvars"
    ;;
  apply)
    terraform apply -auto-approve -var-file="terraform.tfvars"
    ;;
  destroy)
    terraform destroy -auto-approve -var-file="terraform.tfvars"
    ;;
  *)
    logInfoMessage "Not a valid option"
    ;;
esac
