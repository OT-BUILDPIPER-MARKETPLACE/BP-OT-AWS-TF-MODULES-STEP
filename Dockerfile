FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq

ENV SLEEP_DURATION 5s
ENV MODULE_NAME "ELASTICACHE" 

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/$MODULE_NAME
ADD ELASTICACHE/elasticache.tf /opt/buildpiper/
ADD ELASTICACHE/variable.tf /opt/buildpiper/

ENV ACTIVITY_SUB_TASK_CODE TF_ELASTICACHE_EXECUTE
ENV INSTRUCTION "apply"

ENTRYPOINT [ "./build.sh" ]
