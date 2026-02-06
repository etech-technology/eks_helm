{{- define "hello.name" -}}
hello
{{- end -}}

{{- define "hello.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "hello.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hello.labels" -}}
app.kubernetes.io/name: {{ include "hello.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
