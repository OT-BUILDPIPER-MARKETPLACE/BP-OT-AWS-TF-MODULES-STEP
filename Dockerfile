FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq

ENV SLEEP_DURATION 5s
ENV EXTRA_VARS ""

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD modules /opt/buildpiper/modules

ENV ACTIVITY_SUB_TASK_CODE TF_MODULES_EXECUTE
ENV INSTRUCTION "plan"
ENV CUSTOM_VERSION "false"
ENV BUILD_TAG ""
ENV MODULE "ELASTICACHE"

ENTRYPOINT [ "./build.sh" ]
