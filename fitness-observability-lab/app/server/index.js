require('./tracing');
require('./instrumentation');
const express = require('express');
const path = require('path');
const client = require('prom-client');
const app = express();
// WHY prom-client? Observability stack needs metrics
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ timeout: 5000 });
app.use(express.json());
app.use(express.static(path.join(__dirname, '../build')));
// WHY /health? Kubernetes livenessProbe and readinessProbe hit this - must return 200
app.get('/health', (req, res) => {
    res.status(200).json({ status: 'ok', uptime: process.uptime() });
});
// WHY /metrics? Prometheus scrapes this - serviceMonitorEnabled=true needs it
app.get('/metrics', async (req, res) => {
    res.set('Content-Type', client.register.contentType);
    res.end(await client.register.metrics());
});
// API routes here
app.get('/api/fitness', (req, res) => {
    res.json({ message: 'fitness data' });
});
// React fallback
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../build/index.html'));
});
// WHY process.env.PORT? Dockerfile ENV PORT=8080, Helm targetPort 8080 must match
const PORT = process.env.PORT || 8080;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Fitness app listening on 0.0.0.0:${PORT}`);
});