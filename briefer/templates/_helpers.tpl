{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "briefer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "briefer.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "briefer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Global service account, tolerations, and affinity definitions */}}
{{- define "briefer.global.serviceAccount" -}}
{{- .Values.global.serviceAccount | default (printf "%s-sa" .Release.Name) -}}
{{- end -}}

{{- define "briefer.global.tolerations" -}}
{{- .Values.global.tolerations | default list -}}
{{- end -}}

{{- define "briefer.global.affinity" -}}
{{- .Values.global.affinity | default dict -}}
{{- end -}}

{{- define "chart.secret.jupyterToken" -}}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "jupyterToken" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.loginJwtSecret" -}}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "loginJwtSecret" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.authJwtSecret" -}}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "authJwtSecret" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.datasourcesEncryptionKey" }}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "datasourcesEncryptionKey" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.environmentVariablesEncryptionKey" }}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "environmentVariablesEncryptionKey" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.integrationsConfigEncryptionKey" }}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "integrationsConfigEncryptionKey" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}

{{- define "chart.secret.workspaceSecretsEncryptionKey" }}
{{- $root := . -}}
{{- $secretVal := index $root.Values.api.secrets "workspaceSecretsEncryptionKey" -}}
{{- if $secretVal }}
  {{- $secretVal -}}
{{- else }}
  {{- $rand := randAlphaNum 32 | b64enc | sha256sum -}}
  {{- $rand -}}
{{- end }}
{{- end -}}
