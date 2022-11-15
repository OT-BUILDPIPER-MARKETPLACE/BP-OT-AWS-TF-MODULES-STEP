#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh

logInfoMessage "Creating for $MODULE_NAME"
logInfoMessage "I'll create/update [$MODULE_NAME] whose properties are available at [$WORKSPACE] and have mounted at [$CODEBASE_DIR]"
sleep  "$SLEEP_DURATION"

cd  "$WORKSPACE"/"${CODEBASE_DIR}"
cp /opt/buildpiper/eks.tf .
cp /opt/buildpiper/local.tf .
cp /opt/buildpiper/variable.tf .

logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"

terraform init
if [ "$MODULE_NAME" = "EKS" ]; then
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
else
	echo "Please Check Module Name"
fi
