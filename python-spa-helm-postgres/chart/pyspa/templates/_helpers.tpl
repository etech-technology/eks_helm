{{- define "pyspa.name" -}}
pyspa
{{- end -}}

{{- define "pyspa.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "pyspa.labels" -}}
app.kubernetes.io/name: {{ include "pyspa.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
