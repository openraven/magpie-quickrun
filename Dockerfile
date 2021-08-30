FROM quay.io/openraven/magpie:latest
RUN apt update && apt -y install git
COPY config.yaml /magpie/config.yaml
COPY logging.xml /magpie/logging.xml
COPY gcp-credentials.json /magpie/gcp-credentials.json
