unclassified:
  sonarGlobalConfiguration:
    buildWrapperEnabled: false
    installations:
    - credentialsId: "sonarqube-admin-token"
      name: "sonarqube"
      serverUrl: "http://sonarqube-sonarqube.jenkins.svc.cluster.local:9000"
      triggers:
        skipScmCause: false
        skipUpstreamCause: false