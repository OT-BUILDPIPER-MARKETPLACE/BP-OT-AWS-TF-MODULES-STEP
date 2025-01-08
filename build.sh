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


if [[ -n "$ROLE_ARN" ]]; then
  # Calling assumeRole with ROLE_ARN and SESSION_NAME
  assumeRole "$ROLE_ARN" "$SESSION_NAME"
else
  logInfoMessage "ROLE_ARN is empty or not set.Using BP Role"
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