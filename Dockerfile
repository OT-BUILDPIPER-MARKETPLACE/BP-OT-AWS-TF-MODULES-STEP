FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq

ENV SLEEP_DURATION 5s
ENV MODULE_NAME "EKS" 

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD EKS/eks.tf /opt/buildpiper/
ADD EKS/local.tf /opt/buildpiper/
ADD EKS/variable.tf /opt/buildpiper/

ENV ACTIVITY_SUB_TASK_CODE TF_EKS_EXECUTE
ENV INSTRUCTION "apply"

ENTRYPOINT [ "./build.sh" ]
