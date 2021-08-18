@echo off
REM Send directly to Splunk Observability.
REM Presently, only the Jaeger exporter.
REM See https://github.com/signalfx/splunk-otel-java/blob/main/docs/advanced-config.md#trace-exporters for details.

set SPLUNK_ACCESS_TOKEN=%SPLUNK_ACCESS_TOKEN%
set SPLUNK_REALM=%SPLUNK_REALM%
set OTEL_TRACES_EXPORTER=jaeger-thrift-splunk
set OTEL_EXPORTER_JAEGER_ENDPOINT=https://ingest.%SPLUNK_REALM%.signalfx.com/v2/trace

set OTEL_METRICS_EXPORTER=none
set OTEL_RESOURCE_ATTRIBUTES=deployment.environment=petclinic-dev,service.name=PetClinic
java -javaagent:.\otel\splunk-otel-javaagent.jar -jar target\spring-petclinic-2.4.5.jar