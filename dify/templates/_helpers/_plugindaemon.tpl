{{- define "dify.pluginDaemon.db.config" -}}
{{- if .Values.externalPostgres.enabled }}
DB_HOST: {{ .Values.externalPostgres.address }}
DB_PORT: {{ .Values.externalPostgres.port | toString | quote }}
DB_DATABASE: {{ .Values.externalPostgres.database.pluginDaemon | quote }}
{{- else if .Values.postgresql.enabled }}
# N.B.: `pluginDaemon` will the very same `PostgresSQL` database as `api`, `worker`,
# which is NOT recommended for production and subject to possible confliction in the future releases of `dify`
{{- include "dify.db.config" . }}
{{- end }}
{{- end }}

{{- define "dify.pluginDaemon.config" }}
{{- include "dify.redis.config" . }}
{{- include "dify.pluginDaemon.db.config" .}}
{{- include "dify.pluginDaemon.storage.config" .}}
SERVER_PORT: "5002"
PLUGIN_REMOTE_INSTALLING_HOST: "0.0.0.0"
PLUGIN_REMOTE_INSTALLING_PORT: "5003"
MAX_PLUGIN_PACKAGE_SIZE: "52428800"
PLUGIN_STORAGE_LOCAL_ROOT: {{ .Values.pluginDaemon.persistence.mountPath | quote }}
PLUGIN_WORKING_PATH: {{ printf "%s/cwd" .Values.pluginDaemon.persistence.mountPath | clean | quote }}
DIFY_INNER_API_URL: "http://{{ template "dify.api.fullname" . }}:{{ .Values.api.service.port }}"
{{- include "dify.marketplace.config" . }}
{{- end }}

{{- define "dify.pluginDaemon.storage.config" -}}
{{- if and .Values.externalS3.enabled .Values.externalS3.bucketName.pluginDaemon }}
PLUGIN_STORAGE_TYPE: aws_s3
S3_USE_PATH_STYLE: "true"
S3_ENDPOINT: {{ .Values.externalS3.endpoint }}
PLUGIN_STORAGE_OSS_BUCKET: {{ .Values.externalS3.bucketName.pluginDaemon | quote }}
AWS_REGION: {{ .Values.externalS3.region }}
{{- else }}
PLUGIN_STORAGE_TYPE: local
STORAGE_LOCAL_PATH: {{ .Values.pluginDaemon.persistence.mountPath | quote }}
{{- end }}
{{- end }}
