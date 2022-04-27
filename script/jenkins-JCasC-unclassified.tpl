unclassified:
  buildDiscarders:
    configuredBuildDiscarders:
    - "jobBuildDiscarder"
  fingerprints:
    fingerprintCleanupDisabled: false
    storage: "file"
  gitSCM:
    addGitTagAction: false
    allowSecondFetch: false
    createAccountBasedOnEmail: false
    disableGitToolChooser: false
    hideCredentials: false
    showEntireCommitSummaryInChanges: false
    useExistingAccountWithSameEmail: false
  junitTestResultStorage:
    storage: "file"
  location:
    adminAddress: "address not configured yet <nobody@nowhere>"
    url: "http://jenkins:8080/"
  mailer:
    charset: "UTF-8"
    useSsl: false
    useTls: false
  pollSCM:
    pollingThreadCount: 10
  sonarGlobalConfiguration:
    buildWrapperEnabled: false
    installations:
    - credentialsId: "sonarqube-admin-token"
      name: "sonarqube"
      serverUrl: "http://sonarqube-sonarqube.jenkins.svc.cluster.local:9000"
      triggers:
        skipScmCause: false
        skipUpstreamCause: false