{{- define "dify.sandbox.config" -}}
GIN_MODE: release
SANDBOX_PORT: '8194'
{{- if .Values.ssrfProxy.enabled }}
HTTP_PROXY: http://{{ template "dify.ssrfProxy.fullname" .}}:{{ .Values.ssrfProxy.service.port }}
HTTPS_PROXY: http://{{ template "dify.ssrfProxy.fullname" .}}:{{ .Values.ssrfProxy.service.port }}
{{- end }}
{{- end }}
