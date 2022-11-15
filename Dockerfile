FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq

ENV SLEEP_DURATION 5s
ENV MODULE_NAME "EKS" 

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD ${MODULE_NAME}/eks.tf /opt/buildpiper/
ADD ${MODULE_NAME}/local.tf /opt/buildpiper/
ADD ${MODULE_NAME}/variable.tf /opt/buildpiper/

ENV ACTIVITY_SUB_TASK_CODE TF_${MODULE_NAME}_EXECUTE
ENV INSTRUCTION "apply"

ENTRYPOINT [ "./build.sh" ]
