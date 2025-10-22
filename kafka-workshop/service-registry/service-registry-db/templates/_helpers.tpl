{{/*
Expand the name of the chart.
*/}}
{{- define "service-registry-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "service-registry-db.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "service-registry-db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "service-registry-db.labels" -}}
helm.sh/chart: {{ include "service-registry-db.chart" . }}
{{ include "service-registry-db.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "service-registry-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "service-registry-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "service-registry-db.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "service-registry-db.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "service-registry-db.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}

{{/* 
Admin password
*/}}
{{- define "service-registry-db.admin-password" -}}
{{- if .Values.pgsql.adminPassword }}
{{- .Values.pgsql.adminPassword }}
{{- else }}
{{- $secretName := (include "service-registry-db.name" .) }}
{{- $secretObj := (lookup "v1" "Secret" .Release.Namespace $secretName) | default dict }}
{{- $secretData := (get $secretObj "data") | default dict }}
{{- $adminSecret := (get $secretData "database-admin-password") | default (randAlpha 12 | b64enc) }}
{{- $adminSecret | quote }}
{{- end }}
{{- end }}

{{/* 
Define the namespace to depoy the service registry to
*/}}
{{- define "service-registry-db.namespace" -}}
{{- if .Values.namespace }}
{{- .Values.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}
