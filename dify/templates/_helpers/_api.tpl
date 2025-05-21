{{- define "dify.api.config" -}}
# Startup mode, 'api' starts the API server.
MODE: api
# The server port to listen on
SERVER_PORT: "5001"
# The log level for the application. Supported values are `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`
LOG_LEVEL: {{ .Values.api.logLevel }}
# A secret key that is used for securely signing the session cookie and encrypting sensitive information on the database. You can generate a strong key using `openssl rand -base64 42`.
# SECRET_KEY: {{ .Values.api.secretKey }}
# The base URL of console application web frontend, refers to the Console base URL of WEB service if console domain is
# different from api or web app domain.
# example: http://cloud.dify.ai
CONSOLE_WEB_URL: {{ .Values.api.url.consoleWeb | quote }}
# The base URL of console application api server, refers to the Console base URL of WEB service if console domain is
# different from api or web app domain.
# example: http://cloud.dify.ai
CONSOLE_API_URL: {{ .Values.api.url.consoleApi | quote }}
# The URL prefix for Service API endpoints, refers to the base URL of the current API service if api domain is
# different from console domain.
# example: http://api.dify.ai
SERVICE_API_URL: {{ .Values.api.url.serviceApi | quote }}
# The URL prefix for Web APP frontend, refers to the Web App base URL of WEB service if web app domain is different from
# console or api domain.
# example: http://udify.app
APP_WEB_URL: {{ .Values.api.url.appWeb | quote }}
# File preview or download Url prefix.
# used to display File preview or download Url to the front-end or as Multi-model inputs;
# Url is signed and has expiration time.
FILES_URL: {{ .Values.api.url.files | quote }}
{{- include "dify.marketplace.config" . }}
# When enabled, migrations will be executed prior to application startup and the application will start after the migrations have completed.
MIGRATION_ENABLED: {{ .Values.api.migration | toString | quote }}

# The configurations of postgres database connection.
# It is consistent with the configuration in the 'db' service below.
{{- include "dify.db.config" . }}

# The configurations of redis connection.
# It is consistent with the configuration in the 'redis' service below.
{{- include "dify.redis.config" . }}

# The configurations of celery broker.
{{- include "dify.celery.config" . }}
# Specifies the allowed origins for cross-origin requests to the Web API, e.g. https://dify.app or * for all origins.
WEB_API_CORS_ALLOW_ORIGINS: '*'
# Specifies the allowed origins for cross-origin requests to the console API, e.g. https://cloud.dify.ai or * for all origins.
CONSOLE_CORS_ALLOW_ORIGINS: '*'
# CSRF Cookie settings
# Controls whether a cookie is sent with cross-site requests,
# providing some protection against cross-site request forgery attacks
#
# Default: `SameSite=Lax, Secure=false, HttpOnly=true`
# This default configuration supports same-origin requests using either HTTP or HTTPS,
# but does not support cross-origin requests. It is suitable for local debugging purposes.
#
# If you want to enable cross-origin support,
# you must use the HTTPS protocol and set the configuration to `SameSite=None, Secure=true, HttpOnly=true`.
#

{{ include "dify.storage.config" . }}
{{ include "dify.vectordb.config" . }}
{{ include "dify.mail.config" . }}
# The DSN for Sentry error reporting. If not set, Sentry error reporting will be disabled.
SENTRY_DSN: ''
# The sample rate for Sentry events. Default: `1.0`
SENTRY_TRACES_SAMPLE_RATE: "1.0"
# The sample rate for Sentry profiles. Default: `1.0`
SENTRY_PROFILES_SAMPLE_RATE: "1.0"

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

{{- if .Values.sandbox.enabled }}
CODE_EXECUTION_ENDPOINT: http://{{ template "dify.sandbox.fullname" .}}:{{ .Values.sandbox.service.port }}
{{- end }}

{{- if .Values.ssrfProxy.enabled }}
SSRF_PROXY_HTTP_URL: http://{{ template "dify.ssrfProxy.fullname" .}}:{{ .Values.ssrfProxy.service.port }}
SSRF_PROXY_HTTPS_URL: http://{{ template "dify.ssrfProxy.fullname" .}}:{{ .Values.ssrfProxy.service.port }}
{{- end }}

{{- if .Values.pluginDaemon.enabled }}
PLUGIN_DAEMON_URL: http://{{ template "dify.pluginDaemon.fullname" .}}:{{ .Values.pluginDaemon.service.ports.daemon }}
{{- end }}
{{- end }}
