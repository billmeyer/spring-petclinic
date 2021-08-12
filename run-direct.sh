#!/bin/bash

# See https://github.com/signalfx/splunk-otel-java/blob/main/docs/advanced-config.md for additional config options.

# !!! Make sure SPLUNK_ACCESS_TOKEN and SPLUNK_REALM environment variables are set. !!!
if [[ -z "${SPLUNK_ACCESS_TOKEN}" ]]; then
  echo "Environment variable SPLUNK_ACCESS_TOKEN not set, exiting."
  exit -1
fi

if [[ -z "${SPLUNK_REALM}" ]]; then
  echo "Environment variable SPLUNK_REALM not set, exiting."
  exit -1
fi

# Send directly to Splunk Observability.
# Presently, only the Jaeger exporter.
# See https://github.com/signalfx/splunk-otel-java/blob/main/docs/advanced-config.md#trace-exporters for details.

export OTEL_TRACES_EXPORTER=jaeger-thrift-splunk
export OTEL_EXPORTER_JAEGER_ENDPOINT="https://ingest.${SPLUNK_REALM}.signalfx.com/v2/trace"

export OTEL_METRICS_EXPORTER=none
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=petclinic-dev,service.name=PetClinic
java -javaagent:./otel/splunk-otel-javaagent.jar -jar target/*.jar

