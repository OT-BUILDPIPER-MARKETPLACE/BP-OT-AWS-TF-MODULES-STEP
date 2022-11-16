FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq

ENV SLEEP_DURATION 5s

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD modules /opt/buildpiper/modules

ENV ACTIVITY_SUB_TASK_CODE TF_MODULES_EXECUTE
ENV INSTRUCTION "apply"
ENV MODULE "ELASTICACHE"

ENTRYPOINT [ "./build.sh" ]
