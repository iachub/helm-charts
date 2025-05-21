{{- define "dify.worker.config" -}}
# worker service
# The Celery worker for processing the queue.
# Startup mode, 'worker' starts the Celery worker for processing the queue.
MODE: worker

# The base URL of console application web frontend, refers to the Console base URL of WEB service if console domain is
# different from api or web app domain.
# example: http://cloud.dify.ai
CONSOLE_WEB_URL: {{ .Values.api.url.consoleWeb | quote }}
# --- All the configurations below are the same as those in the 'api' service. ---

# The log level for the application. Supported values are `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`
LOG_LEVEL: {{ .Values.worker.logLevel | quote }}
# A secret key that is used for securely signing the session cookie and encrypting sensitive information on the database. You can generate a strong key using `openssl rand -base64 42`.
# same as the API service
# SECRET_KEY: {{ .Values.api.secretKey }}
# The configurations of postgres database connection.
# It is consistent with the configuration in the 'db' service below.
{{ include "dify.db.config" . }}

# The configurations of redis cache connection.
{{ include "dify.redis.config" . }}
# The configurations of celery broker.
{{ include "dify.celery.config" . }}

{{ include "dify.storage.config" . }}
# The Vector store configurations.
{{ include "dify.vectordb.config" . }}
{{ include "dify.mail.config" . }}

# OpenTelemetry configuration
ENABLE_OTEL: "false"
OTLP_BASE_ENDPOINT: "http://localhost:4318"
# OTLP_API_KEY: ""
OTEL_EXPORTER_TYPE: "otlp"
OTEL_SAMPLING_RATE: "0.1"
OTEL_BATCH_EXPORT_SCHEDULE_DELAY: "5000"
OTEL_MAX_QUEUE_SIZE: "2048"
OTEL_MAX_EXPORT_BATCH_SIZE: "512"
OTEL_METRIC_EXPORT_INTERVAL: "60000"
OTEL_BATCH_EXPORT_TIMEOUT: "10000"
OTEL_METRIC_EXPORT_TIMEOUT: "30000"

# Prevent Clickjacking
ALLOW_EMBED: "false"

{{- if .Values.pluginDaemon.enabled }}
PLUGIN_DAEMON_URL: http://{{ template "dify.pluginDaemon.fullname" .}}:{{ .Values.pluginDaemon.service.ports.daemon }}
{{- end }}
{{- include "dify.marketplace.config" . }}
{{- end }}

{{- define "dify.web.config" -}}
# The base URL of console application api server, refers to the Console base URL of WEB service if console domain is
# different from api or web app domain.
# example: http://cloud.dify.ai
CONSOLE_API_URL: {{ .Values.api.url.consoleApi | quote }}
# The URL for Web APP api server, refers to the Web App base URL of WEB service if web app domain is different from
# console or api domain.
# example: http://udify.app
APP_API_URL: {{ .Values.api.url.appApi | quote }}
# Default is not allow to embed into iframe to prevent Clickjacking
NEXT_PUBLIC_ALLOW_EMBED: ""
# The maximum number of top-k value for RAG
NEXT_PUBLIC_TOP_K_MAX_VALUE: "10"
# The maximum number of tokens for segmentation
NEXT_PUBLIC_INDEXING_MAX_SEGMENTATION_TOKENS_LENGTH: "4000"
# Maximum loop count in the workflow
NEXT_PUBLIC_LOOP_NODE_MAX_COUNT: "100"
# Maximum number of tools in the agent/workflow
NEXT_PUBLIC_MAX_TOOLS_NUM: "10"
# Maximum number of Parallelism branches in the workflow
NEXT_PUBLIC_MAX_PARALLEL_LIMIT: "10"
# The maximum number of iterations for agent setting
NEXT_PUBLIC_MAX_ITERATIONS_NUM: "5"
# Website crawling settings
NEXT_PUBLIC_ENABLE_WEBSITE_JINAREADER: "true"
NEXT_PUBLIC_ENABLE_WEBSITE_FIRECRAWL: "true"
NEXT_PUBLIC_ENABLE_WEBSITE_WATERCRAWL: "true"
# The DSN for Sentry
{{- if and .Values.pluginDaemon.enabled .Values.pluginDaemon.marketplace.enabled .Values.pluginDaemon.marketplace.apiProxyEnabled }}
MARKETPLACE_ENABLED: "true"
MARKETPLACE_API_URL: "/marketplace"
{{- else }}
{{- include "dify.marketplace.config" . }}
{{- end }}
MARKETPLACE_URL: {{ .Values.api.url.marketplace | quote }}
{{- end }}
