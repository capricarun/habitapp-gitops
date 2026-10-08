{{- define "habit-tracker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "habit-tracker.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" (include "habit-tracker.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "habit-tracker.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{ include "habit-tracker.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "habit-tracker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "habit-tracker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "habit-tracker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "habit-tracker.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "habit-tracker.secretName" -}}
{{- if .Values.secret.create }}
{{- printf "%s-secret" (include "habit-tracker.fullname" .) }}
{{- else }}
{{- .Values.secret.existingSecret }}
{{- end }}
{{- end }}
