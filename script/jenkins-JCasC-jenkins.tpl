jenkins:
  clouds:
    - kubernetes:
        containerCap: 10
        containerCapStr: "10"
        jenkinsTunnel: "jenkins-agent.jenkins.svc.cluster.local:50000"
        jenkinsUrl: "http://jenkins.jenkins.svc.cluster.local:8080"
        name: "kubernetes"
        namespace: "jenkins"
        podLabels:
          - key: "jenkins/jenkins-jenkins-agent"
            value: "true"
        serverUrl: "https://kubernetes.default"
        templates:
          - containers:
              - envVars:
                  - envVar:
                      key: "JENKINS_URL"
                      value: "http://jenkins.jenkins.svc.cluster.local:8080/"
                image: "jenkins/inbound-agent:4.11-1"
                livenessProbe:
                  failureThreshold: 0
                  initialDelaySeconds: 0
                  periodSeconds: 0
                  successThreshold: 0
                  timeoutSeconds: 0
                name: "jnlp"
                resourceLimitCpu: "512m"
                resourceLimitMemory: "512Mi"
                resourceRequestCpu: "512m"
                resourceRequestMemory: "512Mi"
                workingDir: "/home/jenkins/agent"
            id: "eeb122dab57104444f5bf23ca29f3550fbc187b9d7a51036ea513e2a99fecf0f"
            label: "kube-agent"
            name: "kube-agent"
            namespace: "jenkins"
            podRetention: "never"
            serviceAccount: "default"
            yamlMergeStrategy: "override"
          - containers:
              - alwaysPullImage: true
                image: "jenkins/jnlp-agent-python3:latest"
                livenessProbe:
                  failureThreshold: 0
                  initialDelaySeconds: 0
                  periodSeconds: 0
                  successThreshold: 0
                  timeoutSeconds: 0
                name: "jnlp"
                workingDir: "/home/jenkins/agent"
            id: "5a2ff1e7-d728-4db7-8438-6b9d6f2c31af"
            label: "python-agent"
            name: "python-agent"
            namespace: "jenkins"
            yamlMergeStrategy: "override"
