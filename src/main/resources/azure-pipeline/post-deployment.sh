curl -X POST "http://localhost:8080/api/v1/namespaces/${vvpNamespace}/deployments" \
    -H "Authorization: Bearer ${vvpAPIToken}" \
    -H "accept: application/yaml" -H "Content-Type: application/yaml" -s -d "
kind: Deployment
apiVersion: v1
metadata:
  name: ${vvpJobJarPrefix}-deployment
  namespace: ${vvpNamespace}
spec:
  state: RUNNING
  upgradeStrategy:
    kind: STATELESS
  restoreStrategy:
    kind: LATEST_SAVEPOINT
    allowNonRestoredState: false
  deploymentTargetId: ${vvpDeploymentTarget}
  template:
    metadata:
      annotations: {}
    spec:
      artifact:
        kind: JAR
        jarUri: >-
          wasbs://${blobContainer}@${storageAccount}.blob.core.windows.net/artifacts/namespaces/${vvpNamespace}/${artifactName}?commit=${commitHash}
        flinkVersion: 1.9
        flinkImageRegistry: registry.platform.data-artisans.net/v2.0
        flinkImageRepository: flink
        flinkImageTag: 1.9.1-stream1-scala_2.12
      parallelism: 1
      resources:
        jobmanager:
          cpu: 1
          memory: 1G
        taskmanager:
          cpu: 1
          memory: 2G
      flinkConfiguration: {}
      logging:
        log4jLoggers: {}
status:
  state: CANCELLED
"