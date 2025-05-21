{{- define "dify.vectordb.config" -}}
{{- if .Values.externalWeaviate.enabled }}
# The type of vector store to use. Supported values are `weaviate`, `qdrant`, `milvus`, `pgvector`, `tencent`, `myscale`.
VECTOR_STORE: weaviate
# The Weaviate endpoint URL. Only available when VECTOR_STORE is `weaviate`.
WEAVIATE_ENDPOINT: {{ .Values.externalWeaviate.endpoint | quote }}
# The Weaviate API key.
# WEAVIATE_API_KEY: {{ .Values.externalWeaviate.apiKey }}
{{- else if .Values.externalPgvector.enabled}}
# pgvector configurations, only available when VECTOR_STORE is `pgvecto-rs or pgvector`
VECTOR_STORE: pgvector
PGVECTOR_HOST: {{ .Values.externalPgvector.address }}
PGVECTOR_PORT: {{ .Values.externalPgvector.port | toString | quote }}
PGVECTOR_DATABASE: {{ .Values.externalPgvector.dbName }}
# DB_USERNAME: {{ .Values.externalPgvector.username }}
# DB_PASSWORD: {{ .Values.externalPgvector.password }}
{{- else if .Values.weaviate.enabled }}
# The type of vector store to use. Supported values are `weaviate`, `qdrant`, `milvus`.
VECTOR_STORE: weaviate
  {{- with .Values.weaviate.service }}
    {{- if and (eq .type "ClusterIP") (not (eq .clusterIP "None"))}}
# The Weaviate endpoint URL. Only available when VECTOR_STORE is `weaviate`.
{{/*
Pitfall: scheme (i.e.) must be supecified, or weviate client won't function as
it depends on `hostname` from urllib.parse.urlparse will be empty if schema is not specified.
*/}}
WEAVIATE_ENDPOINT: {{ printf "http://%s" .name | quote }}
    {{- end }}
  {{- end }}
# The Weaviate API key.
  {{- if .Values.weaviate.authentication.apikey }}
# WEAVIATE_API_KEY: {{ first .Values.weaviate.authentication.apikey.allowed_keys }}
  {{- end }}
{{- end }}
{{- end }}
