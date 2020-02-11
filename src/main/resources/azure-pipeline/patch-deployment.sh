echo deploymentId: ${deploymentId}
echo vvpNamespace: ${vvpNamespace}
echo vvp-pipeline-demo-api-token: ${vvp-pipeline-demo-api-token}
echo blobContainer: ${blobContainer}
echo artifactName: ${artifactName}
echo storageAccount: ${storageAccount}
echo commitHash: ${commitHash}

echo curl -X PATCH "http://localhost:8080/api/v1/namespaces/${vvpNamespace}/deployments/${deploymentId}" \
    -H "Authorization: Bearer ${vvp-pipeline-demo-api-token}" \
    -H "accept: application/yaml" -H "Content-Type: application/yaml" -s -d "
    kind: Deployment
    apiVersion: v1
    spec:
      state: RUNNING
      template:
        spec:
          artifact:
            jarUri: >-
              wasbs://${blobContainer}@${storageAccount}.blob.core.windows.net/artifacts/namespaces/${vvpNamespace}/${artifactName}?commit=${commitHash}
    "

curl -X PATCH "http://localhost:8080/api/v1/namespaces/${vvpNamespace}/deployments/${deploymentId}" \
    -H "Authorization: Bearer ${vvp-pipeline-demo-api-token}" \
    -H "accept: application/yaml" -H "Content-Type: application/yaml" -s -d "
    kind: Deployment
    apiVersion: v1
    spec:
      state: RUNNING
      template:
        spec:
          artifact:
            jarUri: >-
              wasbs://${blobContainer}@${storageAccount}.blob.core.windows.net/artifacts/namespaces/${vvpNamespace}/${artifactName}?commit=${commitHash}
    "