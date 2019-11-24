#!/bin/ash -eo pipefail

echo "${INPUT_GCLOUD_SERVICE_KEY}" > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --project=${INPUT_GCLOUD_PROJECT} --key-file=${HOME}/gcloud-service-key.json
gcloud auth configure-docker

OUTPUT_IMAGE="${INPUT_GCLOUD_CONTAINER_REPOSITORY}:${GITHUB_SHA}"
docker tag "${INPUT_INPUT_IMAGE}" "${OUTPUT_IMAGE}"
docker push "${OUTPUT_IMAGE}"

echo ::set-output name=output_image::"${OUTPUT_IMAGE}"
