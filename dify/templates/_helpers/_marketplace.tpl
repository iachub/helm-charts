{{- define "dify.marketplace.config" }}
{{- if .Values.pluginDaemon.marketplace.enabled }}
MARKETPLACE_ENABLED: "true"
MARKETPLACE_API_URL: {{ .Values.api.url.marketplaceApi | quote }}
{{- else }}
MARKETPLACE_ENABLED: "false"
{{- end }}
{{- end }}
