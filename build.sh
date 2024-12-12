#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh

#logInfoMessage "Creating for $MODULE"
tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update terraform code  available at [$tfCodeLocation]"

TAG=$(tail -n -1 $WORKSPACE/data.properties)


cd  "${tfCodeLocation}"
echo $TAG
#cp -r /opt/buildpiper/modules/${MODULE} ${tfCodeLocation}/
#cp /opt/buildpiper/modules/${MODULE}/*.tf .

logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"
if [ "$ASSUME_OTHER_ROLE" == true ]
then
        role_output=$(aws sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME --role-session-name $ROLE_SESSION_NAME)

        # Check if the assume-role command was successful
        if [ $? -ne 0 ]; then
          echo "Failed to assume role."
          exit 1
        fi

        # Parse the JSON output and set environment variables
        AWS_ACCESS_KEY_ID=$(echo $role_output | jq -r '.Credentials.AccessKeyId')
        AWS_SECRET_ACCESS_KEY=$(echo $role_output | jq -r '.Credentials.SecretAccessKey')
        AWS_SESSION_TOKEN=$(echo $role_output | jq -r '.Credentials.SessionToken')

        # Export the variables
        export AWS_ACCESS_KEY_ID
        export AWS_SECRET_ACCESS_KEY
        export AWS_SESSION_TOKEN
fi


terraform init
S3_ARTIFACT_ZIP=${CUSTOM_S3_ARTIFACT_ZIP:-"${SERVICE_NAME}-${TAG}.zip"}
case "$INSTRUCTION" in

  plan)
    terraform init
    terraform plan -var=s3_artifact_zip="${S3_ARTIFACT_ZIP}"
    ;;

  apply)
    terraform apply -auto-approve -var=s3_artifact_zip="${S3_ARTIFACT_ZIP}"
    ;;

  destroy)
    terraform destroy -auto-approve -var=s3_artifact_zip="${S3_ARTIFACT_ZIP}"
    ;;

  *)
    logInfoMessage "Not a valid option"
    ;;
esac