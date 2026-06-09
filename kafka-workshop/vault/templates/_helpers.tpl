{{/*
Expand the name of the chart.
*/}}
{{- define "vault-wrapper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Determine target namespace
*/}}
{{- define "vault-wrapper.namespace" -}}
{{- if .Values.namespace }}
{{- printf "%s" .Values.namespace }}
{{- else }}
{{- printf "%s" .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "vault-wrapper.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.vault) (.Values.argocd.vault.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.vault.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}
