const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');
const sdk = new NodeSDK({
    serviceName: process.env.OTEL_SERVICE_NAME || 'fitness-app',
    traceExporter: new OTLPTraceExporter({
        url: `${process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://tempo.monitoring.svc.cluster.local:4318'}/v1/traces`,
    }),
    instrumentations: [getNodeAutoInstrumentations()],
});
sdk.start();
console.log('OTEL Tracing initialized');
process.on('SIGTERM', () => {
    sdk.shutdown().then(() => console.log('Tracing terminated')).catch(console.error);
});