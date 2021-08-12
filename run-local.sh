#!/bin/bash

# See https://github.com/signalfx/splunk-otel-java/blob/main/docs/advanced-config.md for additional config options.

# Send to a local OpenTelemetry Collector
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
export OTEL_TRACES_EXPORTER=otlp

export OTEL_METRICS_EXPORTER=none
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=petclinic-dev,service.name=PetClinic
java -javaagent:./otel/splunk-otel-javaagent.jar -jar target/*.jar

