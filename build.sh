#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh

logInfoMessage "Creating for $MODULE"
tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update [$MODULE] available at [$tfCodeLocation]"
sleep  "$SLEEP_DURATION"

cd  "${tfCodeLocation}"
cp /opt/buildpiper/modules/* .

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
