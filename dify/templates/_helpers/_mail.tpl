{{- define "dify.mail.config" -}}
{{- if eq .Values.api.mail.type "resend" }}
# Mail configuration for resend
MAIL_TYPE: {{ .Values.api.mail.type | quote }}
MAIL_DEFAULT_SEND_FROM: {{ .Values.api.mail.defaultSender | quote }}
# RESEND_API_KEY: {{ .Values.api.mail.resend.apiKey | quote }}
RESEND_API_URL: {{ .Values.api.mail.resend.apiUrl | quote }}
{{- else if eq .Values.api.mail.type "smtp" }}
# Mail configuration for SMTP
MAIL_TYPE: {{ .Values.api.mail.type | quote }}
MAIL_DEFAULT_SEND_FROM: {{ .Values.api.mail.defaultSender | quote }}
SMTP_SERVER: {{ .Values.api.mail.smtp.server | quote }}
SMTP_PORT: {{ .Values.api.mail.smtp.port | quote }}
# SMTP_USERNAME: {{ .Values.api.mail.smtp.username | quote }}
# SMTP_PASSWORD: {{ .Values.api.mail.smtp.password | quote }}
SMTP_USE_TLS: {{ .Values.api.mail.smtp.tls.enabled | toString | quote }}
SMTP_OPPORTUNISTIC_TLS: {{ .Values.api.mail.smtp.tls.optimistic | toString | quote }}
{{- end }}
{{- end }}
