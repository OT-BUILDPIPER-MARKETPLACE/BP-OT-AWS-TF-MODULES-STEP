function bucketExist() {
    BUCKET=$1

    BUCKET_EXISTS=$(aws s3api head-bucket --bucket $BUCKET 2>&1 || true)
    if [ -z "$BUCKET_EXISTS" ]; then
        echo 0
    else
        echo 1
    fi
}

function copyFileToS3() {
    SOURCE_FILE=$1
    S3_BUCKET=$2
    KEY_NAME=$3

    aws s3 cp ${SOURCE_FILE} s3://${S3_BUCKET}/${KEY_NAME}
}

function assumeRole() {
    local role_arn="$1"
    local session_name="$2"
    

    # Check if session name and role ARN are provided
    if [[ -z "$session_name" || -z "$role_arn" ]]; then
        echo "[Error] Missing arguments. Usage: assumeRole <session_name> <role_arn>"
        return 1
    fi

    echo "[Info] Assuming role with session name: $session_name and role ARN: $role_arn"

    # Attempt to assume the role
    local assume_role_output
    assume_role_output=$(aws sts assume-role \
        --role-arn "$role_arn" \
        --role-session-name "$session_name" 2>&1)

    # Check if the command was successful
    if [[ $? -ne 0 ]]; then
        echo "[Error] Failed to assume role. AWS CLI returned:"
        echo "$assume_role_output"
        return 1
    fi

    # Parse and export temporary credentials
    local access_key
    local secret_key
    local session_token
    access_key=$(echo "$assume_role_output" | jq -r '.Credentials.AccessKeyId')
    secret_key=$(echo "$assume_role_output" | jq -r '.Credentials.SecretAccessKey')
    session_token=$(echo "$assume_role_output" | jq -r '.Credentials.SessionToken')

    if [[ -z "$access_key" || -z "$secret_key" || -z "$session_token" ]]; then
        echo "[Error] Unable to parse credentials from assume-role output."
        return 1
    fi

    export AWS_ACCESS_KEY_ID="$access_key"
    export AWS_SECRET_ACCESS_KEY="$secret_key"
    export AWS_SESSION_TOKEN="$session_token"

    echo "[Info] Successfully assumed role. Temporary credentials set in environment variables."
    return 0
}
