// Why OpenTelemetry? It's the CNCF standard that gives you ONE SDK for Metrics, Traces, Logs
// If you use Prometheus client + Jaeger client separately, you duplicate work.
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-http');
const sdk = new NodeSDK({
    traceExporter: new OTLPTraceExporter({ url: 'http://tempo:3200/v1/traces' }),
    metricExporter: new OTLPMetricExporter({ url: 'http://otel-collector:4318/v1/metrics' }),
    instrumentations: [getNodeAutoInstrumentations()],
});
sdk.start();