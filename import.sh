#!/bin/bash

release="${1}"
resource_type="${2}"
resource_name="${3}"
resource_namespace=${4:-${HELM_NAMESPACE}}

patch="
{
 \"metadata\": {
    \"labels\": {
      \"app.kubernetes.io/managed-by\": \"Helm\"
    },
    \"annotations\": {
      \"meta.helm.sh/release-namespace\": \"${HELM_NAMESPACE}\",
      \"meta.helm.sh/release-name\": \"${release}\"
    }
 }
}
"

kubectl patch "${resource_type}" "${resource_name}" \
  --namespace "${resource_namespace}" \
  --context "${HELM_KUBECONTEXT}" \
  --kubeconfig "${KUBECONFIG}" \
  -p "${patch}"
