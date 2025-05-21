{{- define "dify.db.config" -}}
{{- if .Values.externalPostgres.enabled }}
# DB_USERNAME: {{ .Values.externalPostgres.username }}
# DB_PASSWORD: {{ .Values.externalPostgres.password }}
DB_HOST: {{ .Values.externalPostgres.address }}
DB_PORT: {{ .Values.externalPostgres.port | toString | quote }}
DB_DATABASE: {{ .Values.externalPostgres.database.api | quote }}
{{- else if .Values.postgresql.enabled }}
  {{ with .Values.postgresql.global.postgresql.auth }}
  {{- if empty .username }}
# DB_USERNAME: postgres
# DB_PASSWORD: {{ .postgresPassword }}
  {{- else }}
# DB_USERNAME: {{ .username }}
# DB_PASSWORD: {{ .password }}
  {{- end }}
  {{- end }}
  {{- if eq .Values.postgresql.architecture "replication" }}
DB_HOST: {{ .Release.Name }}-postgresql-primary
  {{- else }}
DB_HOST: {{ .Release.Name }}-postgresql
  {{- end }}
DB_PORT: "5432"
DB_DATABASE: {{ .Values.postgresql.global.postgresql.auth.database }}
{{- end }}
{{- end }}
