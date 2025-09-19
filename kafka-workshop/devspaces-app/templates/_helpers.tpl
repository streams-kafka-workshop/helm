{{/*
Expand the name of the chart.
*/}}
{{- define "devspaces-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "devspaces-app.fullname" -}}
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
{{- define "devspaces-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "devspaces-app.labels" -}}
helm.sh/chart: {{ include "devspaces-app.chart" . }}
{{ include "devspaces-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "devspaces-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devspaces-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "devspaces-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "devspaces-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "devspaces-app.namespace.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.namespace) (.Values.argocd.namespace.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.namespace.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "devspaces-app.checluster.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.checluster) (.Values.argocd.checluster.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.checluster.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "devspaces-app.devspacesNamespace.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.devspacesNamespace) (.Values.argocd.devspacesNamespace.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.devspacesNamespace.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "devspaces-app.devworkspaceTemplate.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.devworkspaceTemplate) (.Values.argocd.devworkspaceTemplate.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.devworkspaceTemplate.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "devspaces-app.devworkspace.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.devworkspace) (.Values.argocd.devworkspace.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.devworkspace.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}
