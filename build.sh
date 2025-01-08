#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh


tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update terraform code  available at [$tfCodeLocation]"

cd  "${tfCodeLocation}"


logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"


if [[ -n "$TF_MODULE_GIT_HOST_NAME" && -n "$TF_MODULE_GIT_USER" && -n "$TF_MODULE_GIT_PAT" ]]; then
  # Generate the ~/.netrc file
  cat <<EOF > ~/.netrc
machine $TF_MODULE_GIT_HOST_NAME
    login $TF_MODULE_GIT_USER
    password $TF_MODULE_GIT_PAT
EOF

  # Set secure permissions
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
  # Verify AWS keys
  if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" ]]; then
    logErrorMessage "AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is not set."
    exit 1
  else
    logInfoMessage "Authentication via AWS Keys"
    export "${AWS_ACCESS_KEY_ID}"
    export "${AWS_SECRET_ACCESS_KEY}"
  fi
elif [[ "$AUTH_METHOD" == "ROLE" ]]; then
  if [[ -n "$ROLE_ARN" ]]; then
    # Calling assumeRole with ROLE_ARN and SESSION_NAME
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
    terraform init
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