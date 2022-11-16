#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh

logInfoMessage "Creating for $MODULE"
logInfoMessage "I'll create/update [$MODULE] whose properties are available at [$WORKSPACE] and have mounted at [$CODEBASE_DIR]"
sleep  "$SLEEP_DURATION"

cd  "$WORKSPACE"/"${CODEBASE_DIR}"
cp /opt/buildpiper/modules/${MODULE}/*.tf .

logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"

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
