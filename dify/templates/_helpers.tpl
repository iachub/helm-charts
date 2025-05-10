{{/*
Return the proper API server fullname
*/}}
{{- define "dify.api.fullname" -}}
{{- printf "%s-api" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Return the proper plugin-daemon fullname
*/}}
{{- define "dify.pluginDaemon.fullname" -}}
{{- printf "%s-plugin-daemon" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper sandbox fullname
*/}}
{{- define "dify.sandbox.fullname" -}}
{{- printf "%s-sandbox" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper ssrf-proxy fullname
*/}}
{{- define "dify.ssrfProxy.fullname" -}}
{{- printf "%s-ssrf-proxy" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper web fullname
*/}}
{{- define "dify.web.fullname" -}}
{{- printf "%s-web" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper web fullname
*/}}
{{- define "dify.worker.fullname" -}}
{{- printf "%s-worker" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Return the proper api image name
*/}}
{{- define "dify.api.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.metrics.image "global" .Values.global) -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Dify API
*/}}
{{- define "dify.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create -}}
    {{ default (include "dify.api.fullname" .) .Values.api.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.api.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Proxy
*/}}
{{- define "dify.proxy.serviceAccountName" -}}
{{- if .Values.proxy.serviceAccount.create -}}
    {{ default (include "dify.nginx.fullname" .) .Values.proxy.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.proxy.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Sandbox
*/}}
{{- define "dify.sandbox.serviceAccountName" -}}
{{- if .Values.sandbox.serviceAccount.create -}}
    {{ default (include "dify.sandbox.fullname" .) .Values.sandbox.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.sandbox.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the ssrfProxy
*/}}
{{- define "dify.ssrfProxy.serviceAccountName" -}}
{{- if .Values.ssrfProxy.serviceAccount.create -}}
    {{ default (include "dify.ssrfProxy.fullname" .) .Values.ssrfProxy.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.ssrfProxy.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Web
*/}}
{{- define "dify.web.serviceAccountName" -}}
{{- if .Values.web.serviceAccount.create -}}
    {{ default (include "dify.web.fullname" .) .Values.web.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.web.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Dify Worker
*/}}
{{- define "dify.worker.serviceAccountName" -}}
{{- if .Values.worker.serviceAccount.create -}}
    {{ default (include "dify.worker.fullname" .) .Values.worker.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.worker.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the Dify Plugin Daemon
*/}}
{{- define "dify.pluginDaemon.serviceAccountName" -}}
{{- if .Values.pluginDaemon.serviceAccount.create -}}
    {{ default (include "dify.pluginDaemon.fullname" .) .Values.pluginDaemon.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{ default "default" .Values.pluginDaemon.serviceAccount.name }}
{{- end -}}
{{- end -}}
