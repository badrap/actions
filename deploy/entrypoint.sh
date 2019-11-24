#!/bin/ash
set -eo pipefail

cd "${GITHUB_WORKSPACE}"

echo "${INPUT_GCLOUD_SERVICE_KEY}" > "${HOME}/gcloud-service-key.json"
gcloud auth activate-service-account --project "${INPUT_GCLOUD_PROJECT}" --key-file="${HOME}/gcloud-service-key.json"
gcloud --quiet container clusters get-credentials -z "${INPUT_CLUSTER_ZONE}" "${INPUT_CLUSTER_NAME}"

export GOOGLE_APPLICATION_CREDENTIALS="${HOME}/gcloud-service-key.json"
sops -d "${INPUT_SECRETS_PATH}" | helm upgrade "${INPUT_HELM_RELEASE}" helm-chart --install --atomic --namespace "${INPUT_HELM_NAMESPACE}" --values - --set image.repository="${INPUT_GCLOUD_CONTAINER_REPOSITORY}" --set image.tag="${GITHUB_SHA}"
