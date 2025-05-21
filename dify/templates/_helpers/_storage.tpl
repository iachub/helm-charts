{{- define "dify.storage.config" -}}
{{- if .Values.externalS3.enabled }}
# The type of storage to use for storing user files. Supported values are `local`, `s3`, `azure-blob`, `aliyun-oss` and `google-storage`, Default: `local`
STORAGE_TYPE: s3
# The S3 storage configurations, only available when STORAGE_TYPE is `s3`.
S3_ENDPOINT: {{ .Values.externalS3.endpoint }}
S3_BUCKET_NAME: {{ .Values.externalS3.bucketName.api }}
# S3_ACCESS_KEY: {{ .Values.externalS3.accessKey }}
# S3_SECRET_KEY: {{ .Values.externalS3.secretKey }}
S3_REGION: {{ .Values.externalS3.region }}
{{- else }}
# The type of storage to use for storing user files. Supported values are `local` and `s3` and `azure-blob`, Default: `local`
STORAGE_TYPE: local
# The path to the local storage directory, the directory relative the root path of API service codes or absolute path. Default: `storage` or `/home/john/storage`.
# only available when STORAGE_TYPE is `local`.
STORAGE_LOCAL_PATH: {{ .Values.api.persistence.mountPath }}
{{- end }}
{{- end }}

